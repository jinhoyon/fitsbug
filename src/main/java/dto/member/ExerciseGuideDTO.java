package dto.member;

import java.util.Date;

/**
 * ↔ EXERCISE_GUIDE 테이블
 *
 * DB 컬럼:
 *   id            INTEGER  PK AUTO_INCREMENT
 *   title         VARCHAR(200) UQ
 *   difficulty    ENUM('초급','중급','고급')
 *   targetMuscle  ENUM('가슴','등','하체','팔','어깨','전신')
 *   type          ENUM('근력','유산소')
 *   description   LONGTEXT
 *   keyPoint      LONGTEXT        ← '|' 구분자로 여러 포인트 저장
 *   image         VARCHAR(255)    ← 썸네일 / GIF 경로
 *   video         VARCHAR(255)    ← YouTube URL
 *   reg_date      DATETIME DEFAULT CURRENT_TIMESTAMP
 */
public class ExerciseGuideDTO {

    // ── DB 컬럼 매핑 ─────────────────────────────────────────
    private int    id;              // DB: id
    private String title;           // DB: title       (이전 name → title)
    private String difficulty;      // DB: difficulty  ENUM('초급','중급','고급')
    private String targetMuscle;    // DB: targetMuscle (이전 muscle → targetMuscle)
    private String type;            // DB: type        ENUM('근력','유산소')  ← 신규
    private String description;     // DB: description
    private String keyPoint;        // DB: keyPoint    '|' 구분자 LONGTEXT  ← 신규
    private String image;           // DB: image       썸네일/GIF 경로       ← 신규
    private String video;           // DB: video       YouTube URL            ← 신규
    private Date   regDate;         // DB: reg_date

    // ── 이전 코드 호환용 별칭 getter/setter ──────────────────
    // guideList.jsp, exerciseCardFragment.jsp 등에서 쓰던 메서드명 유지
    // → 내부적으로 title/targetMuscle/image/video 를 위임

    /** @deprecated title 사용 권장 */
    public int getExerciseId()             { return id; }
    public void setExerciseId(int id)      { this.id = id; }

    /** @deprecated title 사용 권장 */
    public String getName()                { return title; }
    public void setName(String name)       { this.title = name; }

    /** @deprecated targetMuscle 사용 권장 */
    public String getMuscle()             { return targetMuscle; }
    public void setMuscle(String muscle)  { this.targetMuscle = muscle; }

    /** @deprecated image 사용 권장 (DB에 gif_url 컬럼 없음) */
    public String getGifUrl()             { return image; }
    public void setGifUrl(String gifUrl)  { this.image = gifUrl; }

    /** @deprecated image 사용 권장 (DB에 thumbnail 컬럼 없음) */
    public String getThumbnail()              { return image; }
    public void setThumbnail(String thumbnail){ this.image = thumbnail; }

    /** @deprecated video 사용 권장 (DB에 youtube_url 컬럼 없음) */
    public String getYoutubeUrl()             { return video; }
    public void setYoutubeUrl(String url)     { this.video = url; }

    // ── 표준 생성자 ──────────────────────────────────────────
    public ExerciseGuideDTO() {}

    public ExerciseGuideDTO(int id, String title, String difficulty,
                            String targetMuscle, String type,
                            String description, String keyPoint,
                            String image, String video, Date regDate) {
        this.id           = id;
        this.title        = title;
        this.difficulty   = difficulty;
        this.targetMuscle = targetMuscle;
        this.type         = type;
        this.description  = description;
        this.keyPoint     = keyPoint;
        this.image        = image;
        this.video        = video;
        this.regDate      = regDate;
    }

    // ── DB 컬럼 기준 getter / setter ─────────────────────────

    public int getId()                  { return id; }
    public void setId(int id)           { this.id = id; }

    public String getTitle()            { return title; }
    public void setTitle(String title)  { this.title = title; }

    public String getDifficulty()                   { return difficulty; }
    public void setDifficulty(String difficulty)    { this.difficulty = difficulty; }

    public String getTargetMuscle()                 { return targetMuscle; }
    public void setTargetMuscle(String targetMuscle){ this.targetMuscle = targetMuscle; }

    public String getType()             { return type; }
    public void setType(String type)    { this.type = type; }

    public String getDescription()                  { return description; }
    public void setDescription(String description)  { this.description = description; }

    public String getKeyPoint()                     { return keyPoint; }
    public void setKeyPoint(String keyPoint)        { this.keyPoint = keyPoint; }

    public String getImage()            { return image; }
    public void setImage(String image)  { this.image = image; }

    public String getVideo()            { return video; }
    public void setVideo(String video)  { this.video = video; }

    public Date getRegDate()            { return regDate; }
    public void setRegDate(Date regDate){ this.regDate = regDate; }

    @Override
    public String toString() {
        return "ExerciseGuideDTO{id=" + id + ", title='" + title
                + "', targetMuscle='" + targetMuscle + "', difficulty='" + difficulty + "'}";
    }
}