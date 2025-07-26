package wallet

import (
	"path/filepath"
	"testing"
	"time"
)

func TestAddCreditAndBalance(t *testing.T) {
	dir := t.TempDir()
	store, err := NewStore(filepath.Join(dir, "test.db"))
	if err != nil {
		t.Fatal(err)
	}

	sms := "Transfert de 2000 CDF"
	txn := Transaction{Phone: "+243810000111", Amount: 2000, RawSMS: sms, Timestamp: time.Now()}
	if _, err := store.AddCredit(txn); err != nil {
		t.Fatalf("add credit: %v", err)
	}

	bal, err := store.Balance(txn.Phone)
	if err != nil {
		t.Fatalf("balance: %v", err)
	}
	if bal != 2000 {
		t.Fatalf("got balance %d", bal)
	}

	last, err := store.LastTransaction(txn.Phone)
	if err != nil {
		t.Fatalf("last tx: %v", err)
	}
	if last == nil || last.Amount != 2000 {
		t.Fatalf("unexpected last tx: %#v", last)
	}
}

func TestAmountMismatch(t *testing.T) {
	dir := t.TempDir()
	store, err := NewStore(filepath.Join(dir, "test.db"))
	if err != nil {
		t.Fatal(err)
	}
	sms := "Transfert de 1000 CDF"
	txn := Transaction{Phone: "123", Amount: 2000, RawSMS: sms, Timestamp: time.Now()}
	if _, err := store.AddCredit(txn); err == nil {
		t.Fatal("expected error on mismatch")
	}
}
