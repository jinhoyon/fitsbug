#!/usr/bin/env python3
"""One-shot migration: mapper XML namespaces, gym DAO renames, signup controllers."""
import os
import re
import shutil

ROOT = os.path.join(os.path.dirname(__file__), "..")
SRC = os.path.join(ROOT, "src", "main", "java")

# --- Mapper file renames: old relative path -> new relative path (under src/main/java/) ---
MAPPER_FILE_RENAMES = {
    "mapper/admin/adminMain.xml": "mapper/admin/main.xml",
    "mapper/gym/gymMain.xml": "mapper/gym/main.xml",
    "mapper/gym/gymNotice.xml": "mapper/gym/notice.xml",
    "mapper/gym/gymTrainerView.xml": "mapper/gym/trainer_view.xml",
    "mapper/gym/infoEdit.xml": "mapper/gym/info_edit.xml",
    "mapper/gym/memberManage.xml": "mapper/gym/member_manage.xml",
    "mapper/gym/trainerManage.xml": "mapper/gym/trainer_manage.xml",
    "mapper/member/ChartMapper.xml": "mapper/member/chart.xml",
    "mapper/member/ChatMapper.xml": "mapper/member/chat.xml",
    "mapper/member/CommentMapper.xml": "mapper/member/comment.xml",
    "mapper/member/CompleteMapper.xml": "mapper/member/complete.xml",
    "mapper/member/ExerciseGuideMapper.xml": "mapper/member/exercise_guide.xml",
    "mapper/member/GymMapper.xml": "mapper/member/gym.xml",
    "mapper/member/InbodyLogMapper.xml": "mapper/member/inbody_log.xml",
    "mapper/member/InquiryMapper.xml": "mapper/member/inquiry.xml",
    "mapper/member/LessonMapper.xml": "mapper/member/lesson.xml",
    "mapper/member/MealLogMapper.xml": "mapper/member/meal_log.xml",
    "mapper/member/MemberMapper.xml": "mapper/member/member.xml",
    "mapper/member/MembershipMapper.xml": "mapper/member/membership.xml",
    "mapper/member/MessageMapper.xml": "mapper/member/message.xml",
    "mapper/member/MypageMapper.xml": "mapper/member/mypage.xml",
    "mapper/member/NotificationMapper.xml": "mapper/member/notification.xml",
    "mapper/member/PaymentMapper.xml": "mapper/member/payment.xml",
    "mapper/member/PostMapper.xml": "mapper/member/post.xml",
    "mapper/member/PostReactionMapper.xml": "mapper/member/post_reaction.xml",
    "mapper/member/PtFeedbackMapper.xml": "mapper/member/pt_feedback.xml",
    "mapper/member/ReportMapper.xml": "mapper/member/report.xml",
    "mapper/member/ReservationMapper.xml": "mapper/member/reservation.xml",
    "mapper/member/TossMapper.xml": "mapper/member/toss.xml",
    "mapper/member/TrainerCertificationMapper.xml": "mapper/member/trainer_certification.xml",
    "mapper/member/TrainerMapper.xml": "mapper/member/trainer_profile.xml",
    "mapper/member/TrainerPricingMapper.xml": "mapper/member/trainer_pricing.xml",
    "mapper/member/TrainerReviewMapper.xml": "mapper/member/trainer_review.xml",
    "mapper/member/TrainerSpecializationMapper.xml": "mapper/member/trainer_specialization.xml",
    "mapper/member/TrainerTraitsMapper.xml": "mapper/member/trainer_traits.xml",
    "mapper/member/UserMapper.xml": "mapper/member/user.xml",
    "mapper/member/WorkoutLogMapper.xml": "mapper/member/workout_log.xml",
    "mapper/member/trainerListMapper.xml": "mapper/member/trainer_list.xml",
}

MAPPER_FILES_DELETE = [
    "mapper/gym/gymSchedule.xml",
    "mapper/member/TrainerAvailabilityMapper.xml",
]

# Namespace replacements in XML + Java (longest first)
NS_REPLACEMENTS = [
    ("mapper.admin.adminMain", "mapper.admin.main"),
    ("mapper.member.InquiryMapper", "mapper.member.inquiry"),
    ("mapper.member.trainer", "mapper.member.trainer_list"),
    ("mapper.TrainerCertificationMapper", "mapper.member.trainer_certification"),
    ("mapper.TrainerSpecializationMapper", "mapper.member.trainer_specialization"),
    ("mapper.TrainerPricingMapper", "mapper.member.trainer_pricing"),
    ("mapper.TrainerReviewMapper", "mapper.member.trainer_review"),
    ("mapper.TrainerTraitsMapper", "mapper.member.trainer_traits"),
    ("mapper.TrainerMapper", "mapper.member.trainer_profile"),
    ("mapper.ExerciseGuideMapper", "mapper.member.exercise_guide"),
    ("mapper.PostReactionMapper", "mapper.member.post_reaction"),
    ("mapper.WorkoutLogMapper", "mapper.member.workout_log"),
    ("mapper.InbodyLogMapper", "mapper.member.inbody_log"),
    ("mapper.NotificationMapper", "mapper.member.notification"),
    ("mapper.MembershipMapper", "mapper.member.membership"),
    ("mapper.ReservationMapper", "mapper.member.reservation"),
    ("mapper.CompleteMapper", "mapper.member.complete"),
    ("mapper.CommentMapper", "mapper.member.comment"),
    ("mapper.MessageMapper", "mapper.member.message"),
    ("mapper.PtFeedbackMapper", "mapper.member.pt_feedback"),
    ("mapper.MealLogMapper", "mapper.member.meal_log"),
    ("mapper.MyPageMapper", "mapper.member.mypage"),
    ("mapper.PaymentMapper", "mapper.member.payment"),
    ("mapper.ReportMapper", "mapper.member.report"),
    ("mapper.ChartMapper", "mapper.member.chart"),
    ("mapper.LessonMapper", "mapper.member.lesson"),
    ("mapper.MemberMapper", "mapper.member.member"),
    ("mapper.UserMapper", "mapper.member.user"),
    ("mapper.GymMapper", "mapper.member.gym"),
    ("mapper.PostMapper", "mapper.member.post"),
    ("mapper.ChatMapper", "mapper.member.chat"),
    ("mapper.TossMapper", "mapper.member.toss"),
    ("mapper.TrainerUser", "mapper.trainer.user"),
    ("mapper.trainer.settlement", "mapper.trainer.settlement"),  # no-op anchor
    ("mapper.trainer.message", "mapper.trainer.message"),
    ("mapper.trainer.meal", "mapper.trainer.meal"),
    ("pricingAvailability.", "mapper.trainer.pricing_availability."),
    ("payoutAccount.", "mapper.trainer.payout_account."),
    ("trainer.workout.", "mapper.trainer.workout."),
    ("mapper.gymTrainerView", "mapper.gym.trainer_view"),
    ("mapper.memberManage", "mapper.gym.member_manage"),
    ("mapper.trainerManage", "mapper.gym.trainer_manage"),
    ("mapper.gymNotice", "mapper.gym.notice"),
    ("mapper.gymMain", "mapper.gym.main"),
    ("mapper.infoEdit", "mapper.gym.info_edit"),
    ("mapper.dashboard", "mapper.gym.dashboard"),
    ("mapper.membership", "mapper.gym.membership"),
    ("mapper.certification", "mapper.trainer.certification"),
    ("mapper.client", "mapper.trainer.client"),
    ("mapper.notification", "mapper.trainer.notification"),
    ("mapper.payment", "mapper.gym.payment"),
    ("mapper.review", "mapper.gym.review"),
    ("mapper.sales", "mapper.gym.sales"),
    ("mapper.schedule", "mapper.gym.schedule"),
    ("lesson.", "mapper.trainer.lesson."),
    ('"trainer.', '"mapper.trainer.trainer.'),
]

# Gym DAO class renames: old -> new (file base name without .java)
GYM_DAO_RENAMES = {
    "GymMainDAO": "GymProfileDAO",
    "GymMainMembershipDAO": "MembershipCatalogDAO",
    "GymMainTrainerViewDAO": "TrainerViewDAO",
    "GymNoticeDAO": "NoticeDAO",
    "GymReviewDAO": "ReviewDAO",
    "GymScheduleDAO": "ScheduleDAO",
    "GymMemberManageDAO": "MemberManageDAO",
    "GymDashboardDAO": "DashboardDAO",
    "InfoEditDAO": "GymSettingsDAO",
    # keep GymPaymentDAO, GymSalesDAO, TrainerManageDAO
}

GYM_DAO_DELETE = [
    "GymMainNoticeDAO",
    "GymMainReviewDAO",
    "GymMainScheduleDAO",
    "GymTossPaymentDAO",
]

CONTROLLER_RENAMES = {
    "controller/member/Step2Controller.java": "SignupStep2Controller.java",
    "controller/member/Step3Controller.java": "SignupStep3Controller.java",
}


def read_text(path):
    with open(path, "r", encoding="utf-8") as f:
        return f.read()


def write_text(path, content):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)


def apply_replacements(content):
    for old, new in NS_REPLACEMENTS:
        if old != new:
            content = content.replace(old, new)
    return content


def rename_java_class_file(dir_path, old_name, new_name):
    """Rename Foo.java -> Bar.java and update class declaration."""
    old_path = os.path.join(dir_path, old_name + ".java")
    new_path = os.path.join(dir_path, new_name + ".java")
    if not os.path.exists(old_path):
        return False
    content = read_text(old_path)
    content = re.sub(rf"\b{old_name}\b", new_name, content)
    if os.path.exists(new_path):
        os.remove(new_path)
    write_text(new_path, content)
    os.remove(old_path)
    return True


def migrate_mappers():
    for old_rel, new_rel in MAPPER_FILE_RENAMES.items():
        old_path = os.path.join(SRC, old_rel)
        new_path = os.path.join(SRC, new_rel)
        if not os.path.exists(old_path):
            print(f"SKIP mapper missing: {old_rel}")
            continue
        content = apply_replacements(read_text(old_path))
        os.makedirs(os.path.dirname(new_path), exist_ok=True)
        write_text(new_path, content)
        if old_path != new_path:
            os.remove(old_path)
        print(f"mapper {old_rel} -> {new_rel}")

    # Update namespaces in mapper files that were not renamed (trainer/gym in-place)
    for dirpath, _, filenames in os.walk(os.path.join(SRC, "mapper")):
        for fn in filenames:
            if not fn.endswith(".xml"):
                continue
            path = os.path.join(dirpath, fn)
            content = read_text(path)
            new_content = apply_replacements(content)
            if new_content != content:
                write_text(path, new_content)
                print(f"updated namespace in {os.path.relpath(path, SRC)}")

    for rel in MAPPER_FILES_DELETE:
        path = os.path.join(SRC, rel)
        if os.path.exists(path):
            os.remove(path)
            print(f"deleted orphan mapper {rel}")

    config_path = os.path.join(SRC, "resource", "mybatis-config.xml")
    config = read_text(config_path)
    for old_rel, new_rel in MAPPER_FILE_RENAMES.items():
        config = config.replace(f'mapper resource="{old_rel}"', f'mapper resource="{new_rel}"')
    for rel in MAPPER_FILES_DELETE:
        config = re.sub(rf'\s*<mapper resource="{re.escape(rel)}"/>\n', "\n", config)
    write_text(config_path, config)
    print("updated mybatis-config.xml")


def migrate_java_references():
    for dirpath, _, filenames in os.walk(SRC):
        for fn in filenames:
            if not fn.endswith(".java"):
                continue
            path = os.path.join(dirpath, fn)
            content = read_text(path)
            new_content = apply_replacements(content)
            if new_content != content:
                write_text(path, new_content)


def migrate_gym_daos():
    gym_dir = os.path.join(SRC, "dao", "gym")

    # Add merged methods to ReviewDAO and ScheduleDAO before deleting GymMain* counterparts
    review_iface = os.path.join(gym_dir, "GymReviewDAO.java")
    if os.path.exists(review_iface):
        content = read_text(review_iface)
        if "selectRecentReviewByGym" not in content:
            content = content.replace(
                "List<Review> selectReviewListByGymId(int gymId) throws Exception;\n}",
                "List<Review> selectReviewListByGymId(int gymId) throws Exception;\n"
                "\tList<Review> selectRecentReviewByGym(int gymId) throws Exception;\n}",
            )
            write_text(review_iface, content)

    review_impl = os.path.join(gym_dir, "GymReviewDAOImpl.java")
    if os.path.exists(review_impl):
        content = read_text(review_impl)
        if "selectRecentReviewByGym" not in content:
            insert = """
\t@Override
\tpublic List<Review> selectRecentReviewByGym(int gymId) throws Exception {
\t\tSqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
\t\ttry {
\t\t\treturn sqlSession.selectList("mapper.gym.review.selectRecentReviewByGym", gymId);
\t\t} finally {
\t\t\tsqlSession.close();
\t\t}
\t}

}
"""
            content = content.rstrip()
            if content.endswith("}"):
                content = content[:-1] + insert
            write_text(review_impl, content)

    schedule_iface = os.path.join(gym_dir, "GymScheduleDAO.java")
    if os.path.exists(schedule_iface):
        content = read_text(schedule_iface)
        if "selectScheduleByGym" not in content:
            content = content.replace(
                "List<PtSession> selectPtSessionListByGymAndWeek(Map<String, Object> param) throws Exception;\n}",
                "List<PtSessionView> selectPtSessionListByGymAndWeek(Map<String, Object> param) throws Exception;\n"
                "\tSchedule selectScheduleByGym(int gymId) throws Exception;\n}",
            )
            write_text(schedule_iface, content)

    schedule_impl = os.path.join(gym_dir, "GymScheduleDAOImpl.java")
    if os.path.exists(schedule_impl):
        content = read_text(schedule_impl)
        if "selectScheduleByGym" not in content:
            insert = """
\t@Override
\tpublic Schedule selectScheduleByGym(int gymId) throws Exception {
\t\tSqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
\t\ttry {
\t\t\treturn sqlSession.selectOne("mapper.gym.schedule.selectScheduleByGym", gymId);
\t\t} finally {
\t\t\tsqlSession.close();
\t\t}
\t}

}
"""
            content = content.rstrip()
            if content.endswith("}"):
                content = content[:-1] + insert
            # add import if needed
            if "import dto.gym.Schedule;" not in content:
                content = content.replace(
                    "import dto.gym.PtSessionView;",
                    "import dto.gym.PtSessionView;\nimport dto.gym.Schedule;",
                )
            write_text(schedule_impl, content)

    for old, new in GYM_DAO_RENAMES.items():
        rename_java_class_file(gym_dir, old, new)
        rename_java_class_file(gym_dir, old + "Impl", new + "Impl")
        print(f"gym DAO {old} -> {new}")

    for name in GYM_DAO_DELETE:
        for suffix in ("", "Impl"):
            path = os.path.join(gym_dir, name + suffix + ".java")
            if os.path.exists(path):
                os.remove(path)
                print(f"deleted gym DAO {name}{suffix}")

    # Fix GymMainServiceImpl to use merged DAOs
    main_service = os.path.join(SRC, "service", "gym", "GymMainServiceImpl.java")
    if os.path.exists(main_service):
        content = read_text(main_service)
        replacements = {
            "dao.gym.GymMainDAO": "dao.gym.GymProfileDAO",
            "dao.gym.GymMainDAOImpl": "dao.gym.GymProfileDAOImpl",
            "GymMainDAO gymMainDAO": "GymProfileDAO gymProfileDAO",
            "gymMainDAO": "gymProfileDAO",
            "dao.gym.GymMainMembershipDAO": "dao.gym.MembershipCatalogDAO",
            "dao.gym.GymMainMembershipDAOImpl": "dao.gym.MembershipCatalogDAOImpl",
            "GymMainMembershipDAO membershipDAO": "MembershipCatalogDAO membershipCatalogDAO",
            "membershipDAO.selectMembershipByGym": "membershipCatalogDAO.selectMembershipByGym",
            "private GymMainMembershipDAO membershipDAO = new GymMainMembershipDAOImpl();":
                "private MembershipCatalogDAO membershipCatalogDAO = new MembershipCatalogDAOImpl();",
            "dao.gym.GymMainTrainerViewDAO": "dao.gym.TrainerViewDAO",
            "dao.gym.GymMainTrainerViewDAOImpl": "dao.gym.TrainerViewDAOImpl",
            "GymMainTrainerViewDAO trainerViewDAO": "TrainerViewDAO trainerViewDAO",
            "dao.gym.GymMainNoticeDAO": "dao.gym.NoticeDAO",
            "dao.gym.GymMainNoticeDAOImpl": "dao.gym.NoticeDAOImpl",
            "GymMainNoticeDAO noticeDAO": "NoticeDAO noticeDAO",
            "noticeDAO.selectRecentNoticeByGym": "noticeDAO.selectNoticeList",
            "dao.gym.GymMainReviewDAO": "dao.gym.ReviewDAO",
            "dao.gym.GymMainReviewDAOImpl": "dao.gym.ReviewDAOImpl",
            "GymMainReviewDAO reviewDAO": "ReviewDAO reviewDAO",
            "reviewDAO.selectRecentReviewByGym": "reviewDAO.selectRecentReviewByGym",
            "dao.gym.GymMainScheduleDAO": "dao.gym.ScheduleDAO",
            "dao.gym.GymMainScheduleDAOImpl": "dao.gym.ScheduleDAOImpl",
            "GymMainScheduleDAO scheduleDAO": "ScheduleDAO scheduleDAO",
            "scheduleDAO.selectScheduleByGym": "scheduleDAO.selectScheduleByGym",
        }
        for old, new in replacements.items():
            content = content.replace(old, new)
        # clean duplicate notice dao field if needed
        content = re.sub(
            r"private GymMainNoticeDAO noticeDAO = new GymMainNoticeDAOImpl\(\);\n\s*",
            "private NoticeDAO noticeDAO = new NoticeDAOImpl();\n    ",
            content,
        )
        content = re.sub(
            r"private GymMainReviewDAO reviewDAO = new GymMainReviewDAOImpl\(\);\n\s*",
            "private ReviewDAO reviewDAO = new ReviewDAOImpl();\n    ",
            content,
        )
        content = re.sub(
            r"private GymMainScheduleDAO scheduleDAO = new GymMainScheduleDAOImpl\(\);\n\s*",
            "private ScheduleDAO scheduleDAO = new ScheduleDAOImpl();\n    ",
            content,
        )
        write_text(main_service, content)

    # Global gym DAO renames in all Java files
    for dirpath, _, filenames in os.walk(os.path.join(SRC)):
        for fn in filenames:
            if not fn.endswith(".java"):
                continue
            path = os.path.join(dirpath, fn)
            content = read_text(path)
            orig = content
            for old, new in GYM_DAO_RENAMES.items():
                content = content.replace(old, new)
            for name in GYM_DAO_DELETE:
                content = content.replace(name + "Impl", "DELETED_DAO")
                content = content.replace(name, "DELETED_DAO")
            if "DELETED_DAO" in content:
                print(f"WARNING: leftover deleted DAO reference in {path}")
            if content != orig:
                write_text(path, content)


def migrate_controllers():
    member_dir = os.path.join(SRC, "controller", "member")
    for old_rel, new_name in CONTROLLER_RENAMES.items():
        old_path = os.path.join(SRC, old_rel.replace("/", os.sep))
        new_path = os.path.join(member_dir, new_name)
        if not os.path.exists(old_path):
            continue
        content = read_text(old_path)
        old_class = os.path.basename(old_rel).replace(".java", "")
        new_class = new_name.replace(".java", "")
        content = content.replace(f"class {old_class}", f"class {new_class}")
        write_text(new_path, content)
        os.remove(old_path)
        print(f"controller {old_class} -> {new_class}")


def main():
    os.chdir(ROOT)
    print("=== Mapper migration ===")
    migrate_mappers()
    print("=== Java namespace references ===")
    migrate_java_references()
    print("=== Gym DAO migration ===")
    migrate_gym_daos()
    print("=== Controller migration ===")
    migrate_controllers()
    print("DONE")


if __name__ == "__main__":
    main()
