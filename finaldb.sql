-- 1. USER (사용자)
CREATE TABLE USER (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    name VARCHAR(100),
    phone VARCHAR(50),
    email_verified TINYINT(1),
    nickname VARCHAR(100) UNIQUE,
    profile_image VARCHAR(255),
    role ENUM('MEMBER', 'TRAINER', 'GYM', 'ADMIN') NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_deleted BOOLEAN DEFAULT FALSE,
    provider ENUM('kakao', 'naver'),
    provider_id VARCHAR(255)
);

-- 2. GYM (헬스장)
CREATE TABLE GYM (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    user_id INTEGER,
    name VARCHAR(150),
    background_img VARCHAR(150),
    business_registration_num VARCHAR(100) UNIQUE,
    br_file VARCHAR(255),
    phone_num VARCHAR(20),
    address VARCHAR(255),
    address_detail VARCHAR(255),
    postcode VARCHAR(50),
    latitude DECIMAL(10, 7),
    longitude DECIMAL(10, 7),
    description LONGTEXT,
    file VARCHAR(255),
    facility VARCHAR(255),
    approval_status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    gym_code VARCHAR(20),
    bank_name VARCHAR(50),
    account_number VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES USER(id)
);

-- 3. TRAINER (트레이너)
CREATE TABLE TRAINER (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    user_id INTEGER,
    trainer_type ENUM('FREELANCE', 'GYM_EMPLOYED', 'GYM_RENTAL') NOT NULL,
    gym_id INTEGER,
    gym_join_code VARCHAR(10),
    business_registration_num VARCHAR(100) UNIQUE,
    br_file VARCHAR(255),
    has_homeGym BOOLEAN DEFAULT FALSE,
    visit_service BOOLEAN,
    description LONGTEXT,
    address VARCHAR(255),
    address_detail VARCHAR(255),
    postcode VARCHAR(50),
    latitude DECIMAL(10, 7),
    longitude DECIMAL(10, 7),
    approval_status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_verified TINYINT(1) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES USER(id),
    FOREIGN KEY (gym_id) REFERENCES GYM(id)
);

-- 4. MEMBER (회원)
CREATE TABLE MEMBER (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    user_id INTEGER,
    trainer_id INTEGER,
    gym_id INTEGER,
    purpose ENUM('diet', 'balance', 'bulk-up'),
    experience ENUM('first(0)', 'beginner(<1)', 'intermediate(1~3)', 'high(>3)'),
    height INTEGER,
    weight INTEGER,
    diet ENUM('YES', 'Intermediate', 'NO'),
    exerciseCount_goal ENUM('<=2', '3~4', '>5'),
    address VARCHAR(255), -- 이미지상 가산동 등 예시
    latitude DECIMAL(10, 7),
    longitude DECIMAL(10, 7),
    NAME VARCHAR (50),
    goals VARCHAR(50),
    next_session VARCHAR(100),
    lesson_count INTEGER DEFAULT 0,
    total_lessons INTEGER DEFAULT 10,
    last_session VARCHAR(50),
    STATUS VARCHAR(50) DEFAULT 'all',
    age INTEGER,
    FOREIGN KEY (user_id) REFERENCES USER(id),
    FOREIGN KEY (trainer_id) REFERENCES TRAINER(id),
    FOREIGN KEY (gym_id) REFERENCES GYM(id)
);

-- 5. GYM_NOTICE (헬스장 공지사항)
CREATE TABLE GYM_NOTICE (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    gym_id INTEGER,
    title VARCHAR(200) NOT NULL,
    text LONGTEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    view_count BIGINT DEFAULT 0,
    FOREIGN KEY (gym_id) REFERENCES GYM(id)
);

-- 6. IMAGE (이미지 통합 관리)
CREATE TABLE IMAGE (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    notice_id INTEGER, -- 게시글 ID나 리뷰 ID 등 연결용 필드
    image_url LONGTEXT,
    order_index INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (notice_id) REFERENCES GYM_NOTICE(id)
);

-- 7. GYM_SCHEDULE (헬스장 운영 시간)
CREATE TABLE GYM_SCHEDULE (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    gym_id INTEGER,
    available_weekday_start TIME,
    available_weekday_end TIME,
    available_weekend_start TIME,
    available_weekend_end TIME,
    FOREIGN KEY (gym_id) REFERENCES GYM(id)
);

-- 8. REVIEW_GYM (헬스장 리뷰)
CREATE TABLE REVIEW_GYM (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    gym_id INTEGER,
    client_id INTEGER, -- USER 테이블의 id 참조
    rating TINYINT,
    file LONGTEXT,
    comment LONGTEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (gym_id) REFERENCES GYM(id),
    FOREIGN KEY (client_id) REFERENCES USER(id)
);


-- 9. WORKOUT_LOG (운동 큰 틀 기록)
CREATE TABLE WORKOUT_LOG (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    member_id INTEGER,
    session_id INTEGER, -- 루틴이나 세션 구분용
    date DATE, -- 이미지의 date(day of the week) 반영
    start_time TIME,
    end_time TIME,
    gym_id INTEGER,
    FOREIGN KEY (member_id) REFERENCES MEMBER(id),
    FOREIGN KEY (gym_id) REFERENCES GYM(id)
);

-- 10. WORKOUT_DETAIL (세부 운동 종목 및 세트)
CREATE TABLE WORKOUT_DETAIL (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    workout_id INTEGER,
    title VARCHAR(100),
    `set` INTEGER, -- set은 예약어일 수 있어 백틱 사용
    rep INTEGER,
    weight DECIMAL(6, 2),
    FOREIGN KEY (workout_id) REFERENCES WORKOUT_LOG(id)
);

-- 11. MEAL_LOG (식단 기록)
CREATE TABLE MEAL_LOG (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    member_id INTEGER,
    meal_date DATE NOT NULL,
    meal LONGTEXT,
    totcalorie INTEGER,
    FOREIGN KEY (member_id) REFERENCES MEMBER(id)
);

-- 12. INBODY_LOG (인바디/신체 변화)
CREATE TABLE INBODY_LOG (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    member_id INTEGER,
    record_date DATE,
    weight DECIMAL(6, 2),
    muscle_mass DECIMAL(6, 2),
    body_fat DECIMAL(6, 2),
    img VARCHAR(255),
    FOREIGN KEY (member_id) REFERENCES MEMBER(id)
);

-- 13. FEEDBACK (트레이너의 피드백)
CREATE TABLE FEEDBACK (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    workout_id INTEGER,
    meal_id INTEGER,
    inbody_id INTEGER,
    feedback_date DATE,
    summary LONGTEXT,
    comment LONGTEXT,
    next_comment LONGTEXT,
    trainer_id INTEGER,
    FOREIGN KEY (workout_id) REFERENCES WORKOUT_LOG(id),
    FOREIGN KEY (meal_id) REFERENCES MEAL_LOG(id),
    FOREIGN KEY (inbody_id) REFERENCES INBODY_LOG(id),
    FOREIGN KEY (trainer_id) REFERENCES TRAINER(id)
);

-- 14. EXERCISE_GUIDE
CREATE TABLE EXERCISE_GUIDE (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200)UNIQUE,
    difficulty ENUM('초급', '중급', '고급'),
    targetMuscle ENUM('가슴', '등', '하체', '팔', '어깨', '전신'),
    type ENUM('근력', '유산소'),
    description LONGTEXT,
    keyPoint LONGTEXT,
    image VARCHAR(255),
    video VARCHAR(255),
    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 15. MEMBERSHIP (이용권 종별)
CREATE TABLE MEMBERSHIP (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    gym_id INTEGER,
    trainer_id INTEGER,
    type ENUM('day', 'month', 'pt'),
    type_rep INTEGER, -- 개월 수나 횟수
    price DECIMAL(10, 2),
    FOREIGN KEY (gym_id) REFERENCES GYM(id),
    FOREIGN KEY (trainer_id) REFERENCES TRAINER(id)
);

-- 16. MEMBERSHIP_REGISTRATION (결제 및 이용 등록)
CREATE TABLE MEMBERSHIP_REGISTRATION (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    member_id INTEGER,
    membership_id INTEGER,
    register_date DATE,
    start_date DATE,
    end_date DATE,
    status ENUM('active', 'expired'),
    FOREIGN KEY (member_id) REFERENCES MEMBER(id),
    FOREIGN KEY (membership_id) REFERENCES MEMBERSHIP(id)
);

-- 17. POST (커뮤니티 게시글)
CREATE TABLE POST (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    member_id INTEGER,
    post_type ENUM('free', 'exerciseComplete'),
    title VARCHAR(255),
    body LONGTEXT,
    recommended BIGINT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES MEMBER(id)
);

-- 18. COMMENT (게시글 댓글)
CREATE TABLE COMMENT (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    post_num INTEGER,
    user_id INTEGER,
    body LONGTEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_num) REFERENCES POST(id),
    FOREIGN KEY (user_id) REFERENCES USER(id)
);

-- 19. REPORT (신고 내역)
CREATE TABLE REPORT (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    reporter_id INTEGER, -- 신고자
    target_id INTEGER,   -- 피신고자 (사용자 ID)
    post_id INTEGER,     -- 신고된 게시글 ID
    category ENUM('홍보', '부적합', '혐오', '개인정보', '기타'),
    title VARCHAR(200),
    content LONGTEXT,
    file VARCHAR(200),
    result LONGTEXT, -- 처리 결과 설명
    status ENUM('WAIT', 'REJECT', 'HIDE') DEFAULT 'WAIT',
    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    process_date DATETIME,
    FOREIGN KEY (reporter_id) REFERENCES USER(id),
    FOREIGN KEY (target_id) REFERENCES USER(id),
    FOREIGN KEY (post_id) REFERENCES POST(id)
);

-- 20. INQUIRY (고객 문의/1:1 문의)
CREATE TABLE INQUIRY (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    user_id INTEGER,
    category ENUM('계정', '결제', '오류', '제휴', '기타'),
    title VARCHAR(200),
    content LONGTEXT,
    file VARCHAR(200),
    result LONGTEXT,
    status ENUM('WAIT', 'COMPLETE') DEFAULT 'WAIT',
    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    process_date DATETIME,
    FOREIGN KEY (user_id) REFERENCES USER(id)
);

-- 21. CHAT_ROOM (채팅방)
CREATE TABLE CHAT_ROOM (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    user_one INTEGER,
    user_two INTEGER,
    create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_one) REFERENCES USER(id),
    FOREIGN KEY (user_two) REFERENCES USER(id)
);

-- 22. CHAT_MESSAGE (채팅 메시지)
CREATE TABLE CHAT_MESSAGE (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    room_id INTEGER,
    sender_id INTEGER,
    message LONGTEXT,
    is_read TINYINT(1) DEFAULT 0,
    send_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_id) REFERENCES CHAT_ROOM(id),
    FOREIGN KEY (sender_id) REFERENCES USER(id)
);


-- 23. PAYMENT (결제 내역)
CREATE TABLE PAYMENT (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    user_id INTEGER,
    user_name VARCHAR(100),
    membership_id INTEGER,
    mr_id INTEGER, -- MEMBERSHIP_REGISTRATION 참조
    gym_id INTEGER,
    trainer_id INTEGER,
    payment_date DATETIME,
    payment_price DECIMAL(10,2),
    payment_fee DECIMAL(10,2),
    method VARCHAR(50),
    status ENUM('결제완료', '취소완료', '환불요청', '환불완료'),
    payment_type ENUM('MEMBERSHIP', 'PT'),
    canceled_at DATETIME,
    reason LONGTEXT,
    FOREIGN KEY (user_id) REFERENCES USER(id),
    FOREIGN KEY (membership_id) REFERENCES MEMBERSHIP(id),
    FOREIGN KEY (mr_id) REFERENCES MEMBERSHIP_REGISTRATION(id),
    FOREIGN KEY (gym_id) REFERENCES GYM(id),
    FOREIGN KEY (trainer_id) REFERENCES TRAINER(id)
);

-- 24. TOSS (토스 페이먼츠 연동 상세)
CREATE TABLE TOSS (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    user_id INTEGER,
    payment_key VARCHAR(255),
    order_id VARCHAR(255),
    amount BIGINT,
    status VARCHAR(255),
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES USER(id)
);

-- 25. SETTLEMENT (정산 관리)
CREATE TABLE SETTLEMENT (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    target_id INTEGER, -- 트레이너 또는 헬스장 ID
    target_type ENUM('TRAINER', 'GYM'),
    settlement_month VARCHAR(50),
    settlement_deadline VARCHAR(50),
    total_sales DECIMAL(12,2),
    total_fee DECIMAL(12,2),
    net_amount DECIMAL(12,2), -- 최종 입금 금액
    bank_name VARCHAR(100),
    account_number VARCHAR(255),
    status ENUM('정산대기', '정산완료'),
    completed_at DATETIME,
    memo LONGTEXT
);

-- 26. NOTIFICATION (알림 서비스)
CREATE TABLE NOTIFICATION (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    sendType ENUM('admin', 'gym', 'trainer', 'client') NOT NULL,
    sendName VARCHAR(200) NOT NULL,
    title VARCHAR(200) NOT NULL,
    `text` LONGTEXT NOT NULL,
    sendId VARCHAR(100) NOT NULL,
    recvId VARCHAR(100) NOT NULL,
    is_read TINYINT(1) DEFAULT 0 NOT NULL,
    create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    notification_img VARCHAR(100)
);

-- 27. 트레이너 강점
create table TRAINER_SPECIALIZATION(
    id integer AUTO_INCREMENT PRIMARY KEY,
    trainer_id INTEGER,
    `TYPE` LONGTEXT,
    foreign key(trainer_id) references TRAINER(id)
);

-- 28. 트레이너 특성
create table TRAINER_TRAITS(
    id integer auto_increment primary key,
    trainer_id INTEGER,
    `TYPE` LONGTEXT,
    foreign key (trainer_id) references TRAINER(id)
);

-- 29. 트레이너 레슨
create table LESSON(
    id integer auto_increment primary key,
    trainer_id INTEGER,
    client_id   INTEGER,
    start_time  TIME,
    end_time    TIME,
    status      enum ('예약완료', '완료', '취소') default '예약완료',
    notes       LONGTEXT,
    lesson_date VARCHAR(50),
    goal VARCHAR(255),
    created_at  datetime default CURRENT_TIMESTAMP,
    foreign key (trainer_id) references TRAINER (id),
    foreign key (client_id) references MEMBER (id)
);

-- 30. 트레이너 자격증
create table TRAINER_CERTIFICATION(
    id integer auto_increment primary key,
    trainer_id INTEGER,
    cert_name VARCHAR(200),
    issuing_org VARCHAR(200),
    issue_date DATE,
    expiry_date VARCHAR(200),
    cert_file VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    foreign key (trainer_id) references TRAINER (id)
);

-- 31. 트레이너 결제계좌
CREATE TABLE PAYOUT_ACCOUNT(
	 id integer auto_increment primary key,
    trainer_id INTEGER not null,
    trainer_type enum ('FREELANCE_BUSINESS', 'FREELANCE_INDIVIDUAL', 'GYM_EMPLOYEE', 'GYM_COMMISSION', 'GYM_RENTAL') not null,
    gym_id INTEGER,
    commission_rate           decimal(5, 2),
    business_registration_num varchar(100),
    resident_registration_num varchar(255),
    bank_name                 varchar(50),
    account_number            varchar(100),
    is_active                 tinyint(1) DEFAULT 1,
    created_at                datetime   default current_timestamp
);

-- 32. 헬스장 PT정보
CREATE TABLE PT_PACKAGE (
id INTEGER AUTO_INCREMENT PRIMARY KEY,
client_id INTEGER,
trainer_id INTEGER,
mr_id INTEGER,
total_sessions INTEGER NOT NULL,
sessions_used INTEGER DEFAULT 0,
expires_at DATETIME,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (client_id) REFERENCES MEMBER(id),
FOREIGN KEY (trainer_id) REFERENCES TRAINER(id),
FOREIGN KEY (mr_id) REFERENCES MEMBERSHIP_REGISTRATION(id)
);

-- 1. USER (사용자) 더미 데이터
INSERT INTO USER (email, password, name, phone, email_verified, nickname, profile_image, role, provider, provider_id) VALUES
('admin@fit.com', 'hash_pw_1', '관리자', '010-1111-1111', 1, '운영팀장', 'admin_pro.png', 'ADMIN', NULL, NULL),
('gym1@fit.com', 'hash_pw_2', '김철수', '010-2222-2222', 1, '강남헬스마스터', 'gym_owner1.png', 'GYM', NULL, NULL),
('member1@fit.com', 'hash_pw_4', '박지민', '010-4444-4444', 1, '운동꿈나무', 'member1.png', 'MEMBER', 'naver', 'naver_456'),
('member2@fit.com', 'hash_pw_5', '최유리', '010-5555-5555', 0, '건강최고', 'member2.png', 'MEMBER', NULL, NULL),
('member3@fit.com', 'hash_pw_6', '홍길동', '010-1234-5678', 0, '아자아자', 'member3.png', 'MEMBER', NULL, NULL);


-- 2. GYM (헬스장) 더미 데이터 (USER 2번이 사장님인 경우 등)
INSERT INTO GYM (user_id, name, background_img, business_registration_num, br_file, phone_num, address, address_detail, postcode, latitude, longitude, description, facility, approval_status, gym_code, bank_name, account_number) VALUES
(2, '강남 피트니스 센터', 'bg1.jpg', '123-45-67890', 'br_file1.pdf', '02-123-4567', '서울특별시 강남구 테헤란로 123', '4층', '06164', 37.4979420, 127.0276210, '최신식 설비를 갖춘 강남 최고의 센터입니다.', '샤워실, 와이파이, 주차가능', 'APPROVED', 'GN001', '신한은행', '110-123-456789'),
(2, '서초 바디빌드', 'bg2.jpg', '234-56-78901', 'br_file2.pdf', '02-987-6543', '서울특별시 서초구 서초대로 456', '지하 1층', '06611', 37.4918720, 127.0076310, '개인 PT 전문 센터입니다.', '샤워실, 락커룸', 'APPROVED', 'SC001', '국민은행', '2234-567-8901'),
(1, '테스트 헬스장', 'bg3.jpg', '345-67-89012', 'br_file3.pdf', '010-0000-0000', '가산동 123', '2층', '08501', 37.4810000, 126.8820000, '승인 대기 중인 연습용 센터입니다.', '기본 기구', 'PENDING', 'TEST01', '우리은행', '1002-123-456789'),
(2, '역삼 요가&필라테스', 'bg4.jpg', '456-78-90123', 'br_file4.pdf', '02-555-5555', '서울특별시 강남구 역삼로 789', '3층', '06243', 37.4951230, 127.0331230, '여성 전용 깔끔한 시설입니다.', '요가매트, 공용락커', 'APPROVED', 'YS001', '하나은행', '987-654-3210'),
(1, '불허된 센터', 'bg5.jpg', '567-89-01234', 'br_file5.pdf', '02-444-4444', '경기도 성남시 수정구', '1층', '13123', 37.4444440, 127.1111110, '서류 미비 센터입니다.', '없음', 'REJECTED', 'REJ01', '기업은행', '010-222-333333');

-- 3. TRAINER (트레이너) 더미 데이터
INSERT INTO TRAINER (user_id, trainer_type, gym_id, gym_join_code, business_registration_num, br_file, has_homeGym, visit_service, description, address, address_detail, postcode, latitude, longitude, approval_status) VALUES
(3, 'FREELANCE', 1, 'GN001', '999-01-12345', 'trainer_br1.pdf', FALSE, TRUE, '10년 경력의 보디빌딩 전문가입니다.', '서울특별시 강남구', '역삼동 아파트', '06234', 37.498, 127.027, 'APPROVED'),
(3, 'FREELANCE', NULL, NULL, '888-02-23456', 'trainer_br2.pdf', TRUE, TRUE, '찾아가는 홈트레이닝 서비스를 제공합니다.', '서울특별시 송파구', '잠실동', '05551', 37.513, 127.102, 'APPROVED'),
(1, 'GYM_EMPLOYED', 2, 'SC001', '777-03-34567', 'trainer_br3.pdf', FALSE, FALSE, '재활 치료 전문 트레이너입니다.', '서울특별시 서초구', '서초동', '06655', 37.492, 127.008, 'PENDING'),
(3, 'GYM_EMPLOYED', NULL, NULL, '666-04-45678', 'trainer_br4.pdf', FALSE, TRUE, '다이어트 식단 및 유산소 전문입니다.', '경기도 안양시', '동안구', '14034', 37.394, 126.956, 'APPROVED'),
(1, 'GYM_RENTAL', 4, 'YS001', '555-05-56789', 'trainer_br5.pdf', FALSE, FALSE, '불합격된 트레이너 예시입니다.', '서울 어딘가', '지하', '11111', 37.111, 127.111, 'REJECTED');

-- 4. MEMBER (회원) 더미 데이터
INSERT INTO MEMBER (user_id, trainer_id, gym_id, purpose, experience, height, weight, diet, exerciseCount_goal, address, latitude, longitude, NAME, goals, next_session, lesson_count, total_lessons, last_session, STATUS, age) VALUES
(4, 1, 1, 'bulk-up', 'intermediate(1~3)', 180, 75, 'YES', '>5', '서울시 강남구 삼성동', 37.512, 127.058, '박지민', '3대 500 달성', '2026-05-10 10:00', 4, 20, '2026-05-04', 'active', 29),
(5, 1, 1, 'diet', 'beginner(<1)', 165, 60, 'Intermediate', '3~4', '서울시 송파구 잠실동', 37.513, 127.102, '최유리', '바디프로필 촬영', '2026-05-12 14:00', 8, 10, '2026-05-01', 'active', 25),
(4, 2, NULL, 'balance', 'first(0)', 170, 65, 'NO', '<=2', '서울시 강동구', 37.530, 127.123, '박지민', '체력 증진', '2026-05-15 11:00', 1, 5, '2026-05-01', 'active', 29),
(5, NULL, 2, 'diet', 'beginner(<1)', 160, 55, 'YES', '3~4', '서울시 서초구', 37.492, 127.008, '최유리', '체중 -5kg', NULL, 0, 12, NULL, 'pending', 25),
(4, NULL, 4, 'bulk-up', 'high(>3)', 175, 80, 'NO', '>5', '서울시 강남구 역삼동', 37.495, 127.033, '박지민', '근육량 유지', NULL, 10, 10, '2026-04-20', 'completed', 29);

-- 5. GYM_NOTICE (헬스장 공지사항) 더미 데이터
INSERT INTO GYM_NOTICE (gym_id, title, text, view_count) VALUES
(1, '5월 가정의 달 이벤트 안내', '모든 PT 상품 20% 할인 혜택을 드립니다.', 150),
(1, '운영 시간 변경 공지', '새벽 6시부터 밤 12시까지 연장 운영합니다.', 89),
(2, '여름 맞이 바디프로필 반 모집', '선착순 5명에게 무료 식단표를 제공합니다.', 45),
(4, '신규 요가 강사님 소개', '인도에서 오신 전문 강사님과 함께하세요.', 23),
(1, '시설 보수 작업 안내', '이번주 일요일 샤워실 이용이 불가능합니다.', 210);

-- 6. IMAGE (이미지 통합 관리) 더미 데이터
INSERT INTO IMAGE (notice_id, image_url, order_index) VALUES
(1, 'https://storage.com/event_banner.jpg', 1),
(1, 'https://storage.com/event_detail.jpg', 2),
(3, 'https://storage.com/body_profile_info.png', 1),
(5, 'https://storage.com/repair_notice.png', 1),
(2, 'https://storage.com/schedule_table.jpg', 1);

-- 7. GYM_SCHEDULE (헬스장 운영 시간) 더미 데이터
-- GYM 1~5번에 대한 운영 시간 설정
INSERT INTO GYM_SCHEDULE (gym_id, available_weekday_start, available_weekday_end, available_weekend_start, available_weekend_end) VALUES
(1, '06:00:00', '23:00:00', '09:00:00', '18:00:00'),
(2, '07:00:00', '22:00:00', '10:00:00', '15:00:00'),
(3, '00:00:00', '23:59:59', '00:00:00', '23:59:59'), -- 24시 운영
(4, '09:00:00', '21:00:00', NULL, NULL), -- 주말 휴무 예시
(5, '08:00:00', '22:30:00', '09:00:00', '13:00:00');

-- 8. REVIEW_GYM (헬스장 리뷰) 더미 데이터
-- USER 4, 5번(회원)이 GYM 1, 2번에 남긴 리뷰
INSERT INTO REVIEW_GYM (gym_id, client_id, rating, file, comment) VALUES
(1, 4, 5, 'gym_review1.jpg', '시설이 정말 깨끗하고 트레이너 분들이 친절해요!'),
(1, 5, 4, NULL, '기구가 다양해서 좋은데 퇴근 시간에 사람이 좀 많네요.'),
(2, 4, 5, 'gym_review2.png', '개인 PT 받기에 최적화된 공간입니다. 추천해요.'),
(4, 5, 3, NULL, '시설은 좋은데 주말에 운영을 안 해서 아쉬워요.'),
(1, 4, 2, 'bad_review.jpg', '샤워실 온수가 잘 안 나와요. 수리 부탁드립니다.');

-- 9. WORKOUT_LOG (운동 큰 틀 기록) 더미 데이터
-- MEMBER 1, 2번(USER 4, 5번)의 최근 운동 일지
INSERT INTO WORKOUT_LOG (member_id, session_id, date, start_time, end_time, gym_id) VALUES
(1, 101, '2026-05-01', '07:00:00', '08:30:00', 1),
(1, 102, '2026-05-03', '19:00:00', '20:30:00', 1),
(2, 201, '2026-05-01', '10:00:00', '11:00:00', 1),
(2, 202, '2026-05-04', '06:30:00', '08:00:00', 1),
(3, 301, '2026-05-02', '14:00:00', '15:30:00', 2);

-- 10. WORKOUT_DETAIL (세부 운동 종목 및 세트) 더미 데이터
-- WORKOUT_LOG의 ID(1~5)와 연결
INSERT INTO WORKOUT_DETAIL (workout_id, title, `set`, rep, weight) VALUES
(1, '벤치프레스', 5, 10, 60.00),
(1, '데드리프트', 3, 5, 100.00),
(2, '스쿼트', 5, 12, 80.00),
(3, '런닝머신', 1, 30, 0.00), -- 유산소 예시
(4, '숄더프레스', 4, 15, 20.00);

-- 11. MEAL_LOG (식단 기록) 더미 데이터
INSERT INTO MEAL_LOG (member_id, meal_date, meal, totcalorie) VALUES
(1, '2026-05-04', '아침: 닭가슴살 샐러드, 점심: 현미밥과 고등어구이, 저녁: 단백질 쉐이크', 1850),
(2, '2026-05-04', '아침: 사과 1개, 점심: 일반식(반식), 저녁: 샐러드', 1200),
(1, '2026-05-03', '치팅데이: 피자 3조각, 콜라', 2500),
(4, '2026-05-02', '고구마 2개, 닭가슴살 200g, 아몬드 한 줌', 1500),
(5, '2026-05-01', '서브웨이 로티세리 치킨 샌드위치', 1400);

-- 12. INBODY_LOG (인바디/신체 변화) 더미 데이터
-- 기록 날짜에 따른 변화를 테스트하기 위해 같은 유저 데이터를 섞음
INSERT INTO INBODY_LOG (member_id, record_date, weight, muscle_mass, body_fat, img) VALUES
(1, '2026-04-01', 80.50, 35.00, 20.50, 'inbody_start.jpg'),
(1, '2026-05-01', 78.20, 36.50, 18.20, 'inbody_mid.jpg'), -- 한 달 뒤 변화
(2, '2026-05-02', 65.00, 22.00, 30.00, 'inbody_yuri.png'),
(4, '2026-04-15', 72.00, 30.00, 25.00, 'inbody_4.jpg'),
(5, '2026-05-01', 55.00, 20.00, 22.00, 'inbody_5.jpg');

-- 13. FEEDBACK (트레이너의 피드백) 더미 데이터
-- 이전에 생성된 WORKOUT(1~5), MEAL(1~5), INBODY(1~5)와 연결
INSERT INTO FEEDBACK (workout_id, meal_id, inbody_id, feedback_date, summary, comment, next_comment, trainer_id) VALUES
(1, 1, 2, '2026-05-04', '전반적으로 양호하나 단백질 섭취가 부족합니다.', '데드리프트 시 자세가 많이 안정되었습니다. 다만 식단에서 탄수화물 비중을 조금 더 늘려보세요.', '다음 세션에는 스쿼트 중량을 높여보겠습니다.', 1),
(2, 3, 2, '2026-05-05', '치팅데이 이후 컨디션 조절 필요', '어제 피자를 드셔서 그런지 몸이 조금 무거워 보입니다. 오늘은 유산소 비중을 높여주세요.', '내일은 공복 유산소 30분 권장합니다.', 1),
(3, 2, 3, '2026-05-04', '다이어트 순항 중', '식단 조절을 아주 잘해주고 계십니다. 체지방 감소 속도가 적절합니다.', '현재 루틴을 다음 주까지 유지하겠습니다.', 2),
(4, 5, 5, '2026-05-02', '첫 인바디 측정 결과 분석', '근육량에 비해 체지방이 조금 있는 편입니다. 근력 운동 위주로 구성해 드릴게요.', '다음엔 등 운동 위주로 진행하겠습니다.', 3),
(5, 4, 1, '2026-05-03', '기초 체력 향상 확인', '수행 능력이 눈에 띄게 좋아졌습니다. 호흡법만 조금 더 신경 써주세요.', '코어 근육 강화 운동을 추가할 예정입니다.', 1);

-- 14. EXERCISE_GUIDE (운동 가이드) 더미 데이터
INSERT INTO EXERCISE_GUIDE (title, difficulty, targetMuscle, type, description, keyPoint, image, video) VALUES
('컨벤셔널 데드리프트', '중급', '전신', '근력', '전신 근력을 발달시키는 가장 대표적인 운동입니다.', '허리가 굽지 않게 복압을 유지하는 것이 핵심입니다.', 'deadlift_guide.jpg', 'https://video.com/deadlift'),
('바벨 스쿼트', '중급', '하체', '근력', '하체 근육의 왕이라 불리는 다관절 운동입니다.', '무릎이 발끝을 너무 나가지 않게 하며 힙드라이브를 사용하세요.', 'squat_guide.jpg', 'https://video.com/squat'),
('벤치 프레스', '초급', '가슴', '근력', '가슴 근육(대흉근) 발달에 필수적인 운동입니다.', '어깨를 벤치에 고정시키고 바를 수직으로 내리세요.', 'bench_guide.jpg', 'https://video.com/bench'),
('밀리터리 프레스', '중급', '어깨', '근력', '어깨 근육을 강화하고 상체의 안정성을 높입니다.', '반동을 주지 않고 팔꿈치를 수직으로 밀어 올리세요.', 'ohp_guide.jpg', 'https://video.com/ohp'),
('인터벌 러닝', '초급', '전신', '유산소', '고강도와 저강도를 반복하여 체지방 연소를 극대화합니다.', '심박수를 체크하며 본인의 페이스에 맞게 조절하세요.', 'running_guide.jpg', 'https://video.com/running');

-- 15. MEMBERSHIP (이용권 종별) 더미 데이터
-- GYM 1, 2번에 등록된 이용권들
INSERT INTO MEMBERSHIP (gym_id, trainer_id, type, type_rep, price) VALUES
(1, NULL, 'month', 3, 150000.00),     -- 일반 헬스 3개월
(1, 1, 'pt', 10, 600000.00),        -- 1:1 PT 10회 (트레이너 1번)
(2, NULL, 'day', 1, 20000.00),       -- 1일 이용권
(2, 2, 'pt', 20, 1100000.00),       -- 1:1 PT 20회 (트레이너 2번)
(4, NULL, 'month', 12, 500000.00);    -- 연간 회원권

-- 16. MEMBERSHIP_REGISTRATION (결제 및 이용 등록) 더미 데이터
INSERT INTO MEMBERSHIP_REGISTRATION (member_id, membership_id, register_date, start_date, end_date, status) VALUES
(1, 2, '2026-04-01', '2026-04-01', '2026-07-01', 'active'), -- PT 10회 등록 중
(2, 1, '2026-05-01', '2026-05-01', '2026-08-01', 'active'), -- 일반 3개월 등록
(3, 3, '2026-05-04', '2026-05-04', '2026-05-04', 'expired'), -- 1일권 사용 만료
(4, 4, '2026-03-01', '2026-03-01', '2026-09-01', 'active'), -- 장기 PT
(5, 5, '2025-05-01', '2025-05-01', '2026-05-01', 'expired'); -- 작년 연간 회원권 만료

-- 17. POST (커뮤니티 게시글) 더미 데이터
INSERT INTO POST (member_id, post_type, title, body, recommended) VALUES
(1, 'exerciseComplete', '오늘 오운완! 데드리프트 100kg 성공', '드디어 목표하던 중량을 쳤습니다. 기분 최고네요!', 15),
(2, 'free', '가산동 근처 샐러드 맛집 추천해주세요', '운동 끝나고 먹을만한 곳 있을까요?', 3),
(4, 'exerciseComplete', '3개월 바디프로필 준비 시작합니다', '많이 응원해주세요. 식단부터 들어갑니다.', 28),
(1, 'free', '헬스장 신발 어떤게 좋을까요?', '반스 쓰시는 분들 많나요? 리프팅화 살지 고민입니다.', 7),
(5, 'free', 'PT 처음 받아보는데 원래 이렇게 힘든가요?', '근육통 때문에 걷지를 못하겠어요ㅠㅠ', 12);

-- 18. COMMENT (게시글 댓글) 더미 데이터
-- POST 1~5번에 대한 댓글 (USER 1~5번이 골고루 작성)
INSERT INTO COMMENT (post_num, user_id, body) VALUES
(1, 3, '축하드려요! 자세만 조금 더 신경 쓰시면 120kg도 충분하시겠어요.'), -- 트레이너의 댓글
(1, 5, '와 100kg... 진짜 부럽습니다.'),
(2, 4, '역 근처에 있는 샐러디 추천합니다. 연어 맛있어요.'),
(3, 1, '함께 파이팅하시죠! 저도 이번 달에 시작했습니다.'),
(5, 3, '초반에는 근육이 놀라서 그럴 수 있습니다. 스트레칭 자주 해주세요!');

-- 19. REPORT (신고 내역) 더미 데이터
-- 회원들이 게시글(POST 1~5)을 신고하거나 유저를 신고한 상황
INSERT INTO REPORT (reporter_id, target_id, post_id, category, title, content, status, result, process_date) VALUES
(4, 2, 2, '홍보', '게시판 성격에 맞지 않는 광고', '헬스장 홍보가 너무 심합니다.', 'HIDE', '게시글 숨김 처리 완료', '2026-05-04 14:00:00'),
(5, 4, 1, '부적합', '비방 목적의 게시글', '특정인을 비하하는 내용이 포함되어 있습니다.', 'REJECT', '검토 결과 위반 사항 없음', '2026-05-05 10:00:00'),
(4, 3, NULL, '기타', '트레이너 허위 정보 의심', '자격증 정보가 실제와 다른 것 같습니다.', 'WAIT', NULL, NULL),
(5, 1, 4, '개인정보', '타인의 개인정보 노출', '게시글에 핸드폰 번호가 그대로 노출됨', 'HIDE', '관리자에 의해 삭제됨', '2026-05-05 11:30:00'),
(2, 5, 5, '혐오', '불쾌한 표현 사용', '댓글에 욕설 섞인 표현이 있습니다.', 'WAIT', NULL, NULL);

-- 20. INQUIRY (고객 문의) 더미 데이터
INSERT INTO INQUIRY (user_id, category, title, content, status, result, process_date) VALUES
(4, '결제', '결제 취소 요청드립니다.', '실수로 이용권을 잘못 결제했습니다. 환불 부탁드려요.', 'COMPLETE', '환불 처리 완료되었습니다.', '2026-05-04 16:00:00'),
(2, '제휴', '헬스장 등록 관련 문의', '저희 센터를 플랫폼에 등록하고 싶은데 절차가 어떻게 되나요?', 'WAIT', NULL, NULL),
(5, '오류', '로그인이 자꾸 풀려요', '앱 사용 중에 로그인이 해제되는 현상이 반복됩니다.', 'WAIT', NULL, NULL),
(3, '계정', '트레이너 계정 전환 문의', '일반 회원에서 트레이너로 계정을 바꾸고 싶습니다.', 'COMPLETE', '전환 승인 완료되었습니다.', '2026-05-03 09:00:00'),
(4, '기타', '기능 제안합니다.', '식단 기록 시 바코드 스캔 기능이 있으면 좋겠어요.', 'COMPLETE', '개발팀에 전달되었습니다.', '2026-05-05 13:00:00');

-- 21. CHAT_ROOM (채팅방) 더미 데이터
-- 회원(4,5번)과 트레이너(3번) 또는 헬스장(2번) 사이의 채팅방
INSERT INTO CHAT_ROOM (user_one, user_two) VALUES
(4, 3), -- 회원 4와 트레이너 3
(5, 3), -- 회원 5와 트레이너 3
(4, 2), -- 회원 4와 헬스장 2
(5, 2), -- 회원 5와 헬스장 2
(3, 2); -- 트레이너 3과 헬스장 2

-- 22. CHAT_MESSAGE (채팅 메시지) 더미 데이터
-- 위 CHAT_ROOM ID(1~5)와 연결
INSERT INTO CHAT_MESSAGE (room_id, sender_id, message, is_read) VALUES
(1, 4, '선생님 오늘 수업 7시 맞나요?', 1),
(1, 3, '네 맞습니다. 늦지 않게 오세요!', 1),
(2, 5, '식단 사진 보냈습니다. 확인 부탁드려요.', 1),
(3, 4, '일일권 구매했는데 주차 가능한가요?', 0),
(4, 2, '네, 건물 지하 주차장 2시간 무료입니다.', 1);

-- 23. PAYMENT (결제 내역) 더미 데이터
-- MEMBERSHIP_REGISTRATION(mr_id) 1~5번과 매칭
INSERT INTO PAYMENT (user_id, user_name, membership_id, mr_id, gym_id, trainer_id, payment_date, payment_price, payment_fee, method, status, payment_type) VALUES
(4, '박지민', 2, 1, 1, 1, '2026-04-01 10:00:00', 600000.00, 60000.00, 'CARD', '결제완료', 'PT'),
(5, '최유리', 1, 2, 1, NULL, '2026-05-01 14:30:00', 150000.00, 15000.00, 'TOSS', '결제완료', 'MEMBERSHIP'),
(4, '박지민', 3, 3, 2, NULL, '2026-05-04 09:15:00', 20000.00, 2000.00, 'VIRTUAL_ACCOUNT', '결제완료', 'MEMBERSHIP'),
(4, '박지민', 4, 4, 2, 2, '2026-03-01 11:00:00', 1100000.00, 110000.00, 'CARD', '결제완료', 'PT'),
(5, '최유리', 5, 5, 4, NULL, '2025-05-01 10:00:00', 500000.00, 50000.00, 'CARD', '결제완료', 'MEMBERSHIP');

-- 24. TOSS (토스 페이먼츠 상세) 더미 데이터
-- 실제 토스 연동 시 반환되는 값들을 가정한 데이터
INSERT INTO TOSS (user_id, payment_key, order_id, amount, status, created_at) VALUES
(4, 'toss_pk_001', 'order_20260401_001', 600000, 'DONE', '2026-04-01 10:00:00'),
(5, 'toss_pk_002', 'order_20260501_002', 150000, 'DONE', '2026-05-01 14:30:00'),
(4, 'toss_pk_003', 'order_20260504_003', 20000, 'DONE', '2026-05-04 09:15:00'),
(4, 'toss_pk_004', 'order_20260301_004', 1100000, 'DONE', '2026-03-01 11:00:00'),
(5, 'toss_pk_005', 'order_20250501_005', 500000, 'DONE', '2025-05-01 10:00:00');

-- 25. SETTLEMENT (정산 관리) 더미 데이터
-- PAYMENT 내역을 기반으로 한 헬스장(GYM) 및 트레이너(TRAINER) 정산 예시
INSERT INTO SETTLEMENT (target_id, target_type, settlement_month, settlement_deadline, total_sales, total_fee, net_amount, bank_name, account_number, status, completed_at, memo) VALUES
(1, 'GYM', '2026-04', '2026-05-10', 750000.00, 75000.00, 675000.00, '신한은행', '110-123-456789', '정산완료', '2026-05-10 10:00:00', '4월분 정산 완료 건입니다.'),
(1, 'TRAINER', '2026-04', '2026-05-10', 600000.00, 60000.00, 540000.00, '신한은행', '110-999-888777', '정산완료', '2026-05-10 10:00:00', '트레이너 1번 4월 PT 정산'),
(2, 'GYM', '2026-05', '2026-06-10', 1120000.00, 112000.00, 1008000.00, '국민은행', '2234-567-8901', '정산대기', NULL, '5월분 실적 집계 중'),
(2, 'TRAINER', '2026-05', '2026-06-10', 1100000.00, 110000.00, 990000.00, '국민은행', '2234-888-7766', '정산대기', NULL, '트레이너 2번 5월 실적'),
(4, 'GYM', '2026-04', '2026-05-10', 500000.00, 50000.00, 450000.00, '하나은행', '987-654-3210', '정산완료', '2026-05-10 10:00:00', '연간 회원권 결제분 정산');

-- 26. NOTIFICATION (알림 서비스) 더미 데이터
-- sendId와 recvId는 상황에 따라 email이나 USER_ID가 될 수 있어 문자열로 구성
INSERT INTO NOTIFICATION (sendType, sendName, title, text, sendId, recvId, is_read, notification_img) VALUES
('admin', '운영팀', '커뮤니티 가이드라인 공지', '깨끗한 커뮤니티 환경을 위해 공지를 확인해주세요.', 'admin', 'member1@fit.com', 1, 'notif_admin.png'),
('trainer', '이현우', '오늘 수업 일정 안내', '오후 7시 하체 위주 수업 진행 예정입니다.', 'trainer1@fit.com', 'member1@fit.com', 0, 'notif_pt.png'),
('gym', '강남 피트니스', '시설 보수 완료 안내', '샤워실 온수 수리가 완료되었습니다.', 'gym1@fit.com', 'member1@fit.com', 0, 'notif_gym.png'),
('client', '박지민', 'PT 예약 문의', '다음 주 월요일 10시 수업 가능한가요?', 'member1@fit.com', 'trainer1@fit.com', 1, 'notif_chat.png'),
('admin', '시스템', '결제 완료 알림', '이용권 결제가 정상적으로 완료되었습니다.', 'system', 'member2@fit.com', 0, 'notif_pay.png');

-- 27. TRAINER_SPECIALIZATION (트레이너 강점) 더미 데이터
INSERT INTO TRAINER_SPECIALIZATION (trainer_id, TYPE) VALUES
(1, '바디빌딩 및 근비대 전문'),
(1, '파워리프팅 자세 교정'),
(2, '재활 스트레칭 및 통증 완화'),
(2, '체형 교정 및 거북목 개선'),
(3, '다이어트 식단 및 고강도 서킷 트레이닝');

-- 28. TRAINER_TRAITS (트레이너 특성) 더미 데이터
INSERT INTO TRAINER_TRAITS (trainer_id, TYPE) VALUES
(1, '꼼꼼하고 체계적인 피드백'),
(1, '새벽 운동 선호'),
(2, '부드럽고 친절한 소통 방식'),
(3, '열정적이고 강도 높은 수업 스타일'),
(3, '비전공자 눈높이 맞춤 설명');

-- 29. LESSON (트레이너 레슨) 더미 데이터
-- TRAINER(1~3), MEMBER(1~5)와 연계
INSERT INTO LESSON (trainer_id, client_id, start_time, end_time, status, notes, lesson_date) VALUES
(1, 1, '19:00:00', '20:00:00', '완료', '벤치프레스 증량 성공', '2026-05-01'),
(1, 1, '19:00:00', '20:00:00', '예약완료', '데드리프트 집중 피드백 예정', '2026-05-08'),
(1, 2, '14:00:00', '15:00:00', '완료', '식단 가이드 전달 완료', '2026-05-02'),
(2, 3, '11:00:00', '12:00:00', '취소', '개인 사정으로 인한 취소', '2026-05-04'),
(3, 4, '10:00:00', '11:00:00', '예약완료', '첫 수업 - 인바디 상담 포함', '2026-05-10');

-- 30. TRAINER_CERTIFICATION (트레이너 자격증) 더미 데이터
INSERT INTO TRAINER_CERTIFICATION (trainer_id, cert_name, issuing_org, issue_date, expiry_date, cert_file) VALUES
(1, '생활스포츠지도사 2급(보디빌딩)', '문화체육관광부', '2020-07-15', '무기한', 'cert_01.jpg'),
(1, 'NASM-CPT', '미국스포츠의학회', '2022-03-10', '2027-03-10', 'cert_02.jpg'),
(2, '물리치료사 면허', '보건복지부', '2019-02-20', '무기한', 'cert_pt_01.jpg'),
(2, '재활트레이닝 전문가(RTS)', '대한재활협회', '2021-11-05', '2026-11-05', 'cert_pt_02.jpg'),
(3, '운동처방사 1급', '한국자격검정원', '2023-05-20', '2028-05-20', 'cert_03.jpg');

-- 32. PT_PACKAGE 더미데이터
INSERT INTO PT_PACKAGE (client_id, trainer_id, mr_id, total_sessions, sessions_used, expires_at) VALUES
(3,1,3,10,2,'2026-06-10 23:59:59'),
(5,2,5,20,5,'2026-07-15 23:59:59'),
(1,1,1,10,0,'2026-05-01 23:59:59'),
(2,2,2,15,3,'2026-07-05 23:59:59'),
(4,1,4,10,1,'2026-05-10 23:59:59');