package main

import (
	"encoding/json"
	"log"
	"net/http"
	"time"

	"github.com/go-chi/chi/v5"
	_ "github.com/mattn/go-sqlite3"

	"github.com/example/wallet-plugin-go/internal/wallet"
)

func main() {
	store, err := wallet.NewStore("wallet.db")
	if err != nil {
		log.Fatal(err)
	}

	r := chi.NewRouter()
	r.Post("/api/credits", func(w http.ResponseWriter, r *http.Request) {
		var body struct {
			Phone     string    `json:"phone"`
			Amount    int64     `json:"amount"`
			Timestamp time.Time `json:"timestamp"`
			RawSMS    string    `json:"raw_sms"`
		}
		if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
			w.WriteHeader(http.StatusBadRequest)
			return
		}
		id, err := store.AddCredit(wallet.Transaction{
			Phone:     body.Phone,
			Amount:    body.Amount,
			RawSMS:    body.RawSMS,
			Timestamp: body.Timestamp,
		})
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(map[string]any{"id": id})
	})

	r.Post("/wallet/{phone}/debit", func(w http.ResponseWriter, r *http.Request) {
		phone := chi.URLParam(r, "phone")
		var body struct {
			Amount int64  `json:"amount"`
			Ref    string `json:"ref"`
		}
		if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
			w.WriteHeader(http.StatusBadRequest)
			return
		}
		id, err := store.AddDebit(phone, body.Amount, body.Ref)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			return
		}
		json.NewEncoder(w).Encode(map[string]any{"id": id})
	})

	r.Get("/parsers", func(w http.ResponseWriter, r *http.Request) {
		ps, err := store.Parsers()
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			return
		}
		json.NewEncoder(w).Encode(ps)
	})

	r.Post("/parsers", func(w http.ResponseWriter, r *http.Request) {
		var p wallet.Parser
		if err := json.NewDecoder(r.Body).Decode(&p); err != nil {
			w.WriteHeader(http.StatusBadRequest)
			return
		}
		id, err := store.AddParser(p)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			return
		}
		json.NewEncoder(w).Encode(map[string]any{"id": id})
	})
	r.Get("/wallet/{phone}", func(w http.ResponseWriter, r *http.Request) {
		phone := chi.URLParam(r, "phone")
		bal, err := store.Balance(phone)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(map[string]any{"balance": bal})
	})
	r.Get("/healthz", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
	})

	log.Println("listening on :8080")
	http.ListenAndServe(":8080", r)
}
