package wallet

import (
	"database/sql"
	"errors"
	"regexp"
	"strconv"
	"strings"
	"time"

	_ "github.com/mattn/go-sqlite3"
)

type Store struct {
	db *sql.DB
}

type Transaction struct {
	ID        int64
	Phone     string
	Amount    int64
	RawSMS    string
	Timestamp time.Time
}

var amountRx = regexp.MustCompile(`([0-9]+)`)

func NewStore(path string) (*Store, error) {
	db, err := sql.Open("sqlite3", path)
	if err != nil {
		return nil, err
	}
	if _, err := db.Exec(`CREATE TABLE IF NOT EXISTS transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        phone TEXT NOT NULL,
        amount INTEGER NOT NULL,
        raw_sms TEXT NOT NULL,
        ts DATETIME NOT NULL
    )`); err != nil {
		return nil, err
	}
	return &Store{db: db}, nil
}

func parseAmount(raw string) (int64, error) {
	match := amountRx.FindString(raw)
	if match == "" {
		return 0, errors.New("amount not found")
	}
	return strconv.ParseInt(match, 10, 64)
}

func (s *Store) AddCredit(txn Transaction) (int64, error) {
	if txn.Phone == "" || txn.Amount <= 0 || txn.RawSMS == "" {
		return 0, errors.New("invalid transaction")
	}

	parsed, err := parseAmount(strings.ReplaceAll(txn.RawSMS, " ", ""))
	if err != nil {
		return 0, err
	}
	if parsed != txn.Amount {
		return 0, errors.New("amount mismatch")
	}

	res, err := s.db.Exec(`INSERT INTO transactions(phone,amount,raw_sms,ts) VALUES(?,?,?,?)`,
		txn.Phone, txn.Amount, txn.RawSMS, txn.Timestamp)
	if err != nil {
		return 0, err
	}
	return res.LastInsertId()
}

func (s *Store) Balance(phone string) (int64, error) {
	var bal sql.NullInt64
	err := s.db.QueryRow(`SELECT COALESCE(SUM(amount),0) FROM transactions WHERE phone=?`, phone).Scan(&bal)
	if err != nil {
		return 0, err
	}
	if !bal.Valid {
		return 0, nil
	}
	return bal.Int64, nil
}

func (s *Store) LastTransaction(phone string) (*Transaction, error) {
	row := s.db.QueryRow(`SELECT id, phone, amount, raw_sms, ts FROM transactions WHERE phone=? ORDER BY id DESC LIMIT 1`, phone)
	var t Transaction
	if err := row.Scan(&t.ID, &t.Phone, &t.Amount, &t.RawSMS, &t.Timestamp); err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, nil
		}
		return nil, err
	}
	return &t, nil
}
