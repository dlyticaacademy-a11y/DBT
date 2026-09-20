

INSERT INTO hist_transactional
    (tran_id, account_id, branch_id, tran_amount, tran_crncy,
     tran_date, tran_particular, tran_remarks, created_date, modified_date)
VALUES
    ('TXN0000401', 'AC000151', 'BR001', 50000.00, 'NPR', '2026-09-21', 'Loan Disbursement', 'New loan account disbursed', '2026-09-21 10:00:00', '2026-09-21 10:00:00'),
    ('TXN0000402', 'AC000152', 'BR002', 25000.00, 'NPR', '2026-09-21', 'Cash Deposit', 'Deposited at branch counter', '2026-09-21 10:15:00', '2026-09-21 10:15:00'),
    ('TXN0000403', 'AC000002', 'BR008', 4200.50, 'NPR', '2026-09-21', 'Salary Credit', 'Monthly salary credit', '2026-09-21 11:00:00', '2026-09-21 11:00:00'),
    ('TXN0000404', 'AC000005', 'BR016', 1200.00, 'NPR', '2026-09-21', 'ATM Withdrawal', 'ATM cash withdrawal', '2026-09-21 12:30:00', '2026-09-21 12:30:00');
