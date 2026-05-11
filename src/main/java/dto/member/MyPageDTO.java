package dto.member;

import java.util.Map;

public class MyPageDTO {

    private Map<String, Object> member;

    public MyPageDTO() {}

    public MyPageDTO(Map<String, Object> member) {
        this.member = member;
    }

    public Map<String, Object> getMember() { return member; }
    public void setMember(Map<String, Object> member) { this.member = member; }

    public Map<String, Object> getPlan()           { return member; }
    public void setPlan(Map<String, Object> m)     { this.member = m; }
    public void setUser(Map<String, Object> m)     { this.member = m; }
    public Map<String, Object> getUser()           { return member; }
}
