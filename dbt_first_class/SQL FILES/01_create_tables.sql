-- ============================================================
-- Nabil Bank sample data model — CREATE TABLE statements
-- Dialect: ANSI SQL / PostgreSQL-compatible
-- ============================================================

DROP TABLE IF EXISTS branch CASCADE;
DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS account CASCADE;
DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS lien CASCADE;
DROP TABLE IF EXISTS ratelist CASCADE;

CREATE TABLE branch (
    branch_sol_id VARCHAR(10),
    branch_open_date DATE,
    city_code VARCHAR(10),
    address1 VARCHAR(100),
    address2 VARCHAR(100),
    branch_code VARCHAR(10),
    branch_description VARCHAR(150),
    state_code VARCHAR(50),
    lchg_user_id VARCHAR(30),
    lchg_time DATE,
    CONSTRAINT pk_branch PRIMARY KEY (branch_sol_id)
);

CREATE TABLE customer (
    cif_id VARCHAR(15),
    full_name VARCHAR(150),
    cust_first_name VARCHAR(50),
    cust_middle_name VARCHAR(50),
    cust_last_name VARCHAR(50),
    primary_sol_id VARCHAR(10),
    crncy_code VARCHAR(5),
    occupation VARCHAR(50),
    education VARCHAR(30),
    riskrating VARCHAR(10),
    pan VARCHAR(15),
    status VARCHAR(20),
    email VARCHAR(100),
    phone_home VARCHAR(20),
    constitution_code VARCHAR(10),
    segmentation_class VARCHAR(20),
    staffflag VARCHAR(1),
    blacklisted VARCHAR(1),
    seniorcitizen VARCHAR(1),
    relationshipopeningdate DATE,
    bodatecreated DATE,
    CONSTRAINT pk_customer PRIMARY KEY (cif_id),
    CONSTRAINT fk_customer_primary_sol_id FOREIGN KEY (primary_sol_id) REFERENCES branch(branch_sol_id)
);

CREATE TABLE account (
    acid VARCHAR(15),
    foracid VARCHAR(16),
    cif_id VARCHAR(15),
    cust_id VARCHAR(15),
    sol_id VARCHAR(10),
    acct_name VARCHAR(150),
    acct_ownership VARCHAR(1),
    schm_type VARCHAR(5),
    schm_code VARCHAR(10),
    product_category VARCHAR(20),
    product_sub_category VARCHAR(30),
    gl_sub_head_code VARCHAR(10),
    acct_opn_date DATE,
    acct_cls_flg VARCHAR(1),
    acct_cls_date DATE,
    acct_status VARCHAR(20),
    acct_crncy_code VARCHAR(5),
    clr_bal_amt DECIMAL(18,2),
    sanct_lim DECIMAL(18,2),
    drwng_power DECIMAL(18,2),
    lien_amt DECIMAL(18,2),
    available_amount DECIMAL(18,2),
    interest_rate DECIMAL(6,2),
    last_tran_date DATE,
    del_flg VARCHAR(1),
    entity_cre_flg VARCHAR(1),
    lchg_user_id VARCHAR(30),
    lchg_time DATE,
    CONSTRAINT pk_account PRIMARY KEY (acid),
    CONSTRAINT uq_account_foracid UNIQUE (foracid),
    CONSTRAINT fk_account_cif_id FOREIGN KEY (cif_id) REFERENCES customer(cif_id),
    CONSTRAINT fk_account_sol_id FOREIGN KEY (sol_id) REFERENCES branch(branch_sol_id),
    CONSTRAINT chk_account_rule CHECK (acct_ownership IN ('C','O','E'))
);

CREATE TABLE transactions (
    transaction_key VARCHAR(30),
    tran_id VARCHAR(15),
    part_tran_srl_num SMALLINT,
    acid VARCHAR(15),
    cust_id VARCHAR(15),
    tran_date DATE,
    year SMALLINT,
    month SMALLINT,
    day SMALLINT,
    tran_particular VARCHAR(50),
    tran_rmks VARCHAR(100),
    tran_type VARCHAR(10),
    tran_sub_type VARCHAR(20),
    part_tran_type VARCHAR(2),
    tr_status VARCHAR(2),
    gl_sub_head_code VARCHAR(10),
    ref_num VARCHAR(30),
    acct_balance DECIMAL(18,2),
    sol_id VARCHAR(10),
    dth_init_sol_id VARCHAR(10),
    tran_amt DECIMAL(18,2),
    tran_crncy_code VARCHAR(5),
    ref_crncy_code VARCHAR(5),
    tran_channel_type VARCHAR(15),
    pstd_flg VARCHAR(1),
    lchg_time DATE
);

CREATE TABLE lien (
    b2k_id VARCHAR(40),
    acid VARCHAR(15),
    sol_id VARCHAR(10),
    lien_amt DECIMAL(18,2),
    lien_reason_code VARCHAR(10),
    lien_remarks VARCHAR(150),
    lien_start_date DATE,
    lien_expiry_date DATE,
    requested_by_desc VARCHAR(50),
    request_department VARCHAR(50),
    contact_num VARCHAR(20),
    b2k_type VARCHAR(10),
    entity_cre_flg VARCHAR(1),
    del_flg VARCHAR(1),
    lchg_user_id VARCHAR(30),
    lchg_time DATE
);

CREATE TABLE ratelist (
    rtlist_date DATE,
    rtlist_num SMALLINT,
    fxd_crncy_code VARCHAR(5),
    var_crncy_code VARCHAR(5),
    ratecode VARCHAR(5),
    fxd_crncy_units INT,
    var_crncy_units DECIMAL(18,4),
    cust_var_crncy_units DECIMAL(18,4),
    low_slab_amt DECIMAL(18,2),
    high_slab_amt DECIMAL(18,2),
    slab_crncy_code VARCHAR(5),
    srl_num INT,
    bank_id VARCHAR(5),
    lchg_user_id VARCHAR(30),
    lchg_time DATE,
    CONSTRAINT pk_ratelist PRIMARY KEY (srl_num),
    CONSTRAINT chk_ratelist_rule CHECK (ratecode IN ('CSB','NCB','SEL','REV'))
);
