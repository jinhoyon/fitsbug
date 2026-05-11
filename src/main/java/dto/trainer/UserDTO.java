package dto.trainer;

import java.time.LocalDateTime;

public class UserDTO {
    private int id;
    private String email;
    private String password;
    private String name;
    private String phone;
    private String nickname;
    private String profileImage;
    private UserRole role;
    private LocalDateTime createdAt;
    private boolean deleted;
    private String provider;
    private String providerId;
    private int age;
    private String gender;

    public enum UserRole {
        MEMBER,
        TRAINER,
        GYM,
        ADMIN
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }



    public String getProfileImg() {
		return profileImage;
	}

	public void setProfileImg(String profileImg) {
		this.profileImage = profileImg;
	}

	public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public String getProvider() {
        return provider;
    }

    public void setProvider(String provider) {
        this.provider = provider;
    }

    public String getProviderId() {
        return providerId;
    }

    public void setProviderId(String providerId) {
        this.providerId = providerId;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

	@Override
	public String toString() {
		return "UserDTO [id=" + id + ", email=" + email + ", password=" + password + ", name=" + name + ", phone=" + phone
				+ ", nickname=" + nickname + ", profileImage=" + profileImage + ", role=" + role + ", createdAt="
				+ createdAt + ", deleted=" + deleted + ", provider=" + provider + ", providerId=" + providerId + "]";
	}
    
    
}
