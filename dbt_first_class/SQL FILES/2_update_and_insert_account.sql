
UPDATE account
SET
    account_balance = -145000.00,
    lchg_time = '2026-09-21 00:00:00'
WHERE
    account_id = 'AC000001';

INSERT INTO account
    (account_id, customer_id, branch_id, account_balance,
     lien_amt, acct_cls_flg, product_id, schm_type,
     schm_code, acct_crncy_code, lchg_time)
VALUES
    ('AC000151', 'C0051', 'BR001', -50000.00, 0, 'N', 'PRD012', 'LD', 'LON001', 'NPR', '2026-09-21 00:00:00'),
    ('AC000152', 'C0002', 'BR002', 25000.00, 0, 'N', 'PRD001', 'SA', 'SAV001', 'NPR', '2026-09-21 00:00:00');
