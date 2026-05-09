package com.example.demo.entity;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "users")

public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    @NotBlank(message = "Email cannot be blank")
    private String email;

    @Column(nullable = false)
    @NotBlank(message = "Name cannot be blank")
    private String name;

    @Column(nullable = false)
    @NotBlank(message = "Password cannot be blank")
    @Size(min = 6, message = "Password must be at least 6 characters long")
    private String password;
    
    @Min(value = 30, message = "Height must be at least 30 cm")
    @Max(value = 250, message = "Height must be at most 250 cm")
    @NotNull(message = "Height cannot be blank")
    private Float height;

    @NotNull(message = "Weight cannot be blank")
    @Min(value = 20, message = "Weight must be at least 20 kg")
    private Float weight;

    @NotNull(message = "Age cannot be blank")
    @Min(value = 10, message = "Age must be at least 10")
    @Max(value = 100, message = "Age must be at most 100")
    private Integer age;

    @Column(nullable = false)
    @NotBlank(message = "Gender cannot be blank")
    private String gender;

    private String goal;

    private Double trainingFrequency;
    
    private Integer xp = 0;
    private Integer streakDays = 0;
    private Integer tdee;

    private String petType;           // Elemental type: fire, water, grass, electric
    private Integer petLevel = 1;    // Pet level: 1-20
    private Integer petExp = 0;       // Current accumulated experience points
    private Integer petMood = 100;    // Mood value: 0-100
    private Integer petEnergy = 100;  // Energy value: 0-100
    private LocalDateTime petLastActive;  // Last activity timestamp
    private Integer petStage = 0;     // Appearance stage: 0=Baby, 1=Teen, 2=Adult, 3=Full Grown

    
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public Float getHeight() { return height; }
    public void setHeight(Float height) { this.height = height; }

    public Float getWeight() { return weight; }
    public void setWeight(Float weight) { this.weight = weight; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public Integer getAge() {
        return age;
    }
    public void setAge(Integer age) {
        this.age = age;
    }
    public String getGoal() {
        return goal;
    }
    public void setGoal(String goal) {
        this.goal = goal;
    }
    public Double getTrainingFrequency() {
        return trainingFrequency;
    }
    public void setTrainingFrequency(Double trainingFrequency) {
        this.trainingFrequency = trainingFrequency;
    }
    public Integer getXp() {
        return xp;
    }
    public void setXp(Integer xp) {
        this.xp = xp;
    }
    public Integer getStreakDays() {
        return streakDays;
    }
    public void setStreakDays(Integer streakDays) {
        this.streakDays = streakDays;
    }
    public Integer getTdee() {
        return tdee;
    }
    public void setTdee(Integer tdee) {
        this.tdee = tdee;
    }

    public String getPetType() { return petType; }
    public void setPetType(String petType) { this.petType = petType; }

    public Integer getPetLevel() { return petLevel; }
    public void setPetLevel(Integer petLevel) { this.petLevel = petLevel; }

    public Integer getPetExp() { return petExp; }
    public void setPetExp(Integer petExp) { this.petExp = petExp; }

    public Integer getPetMood() { return petMood; }
    public void setPetMood(Integer petMood) { this.petMood = petMood; }

    public Integer getPetEnergy() { return petEnergy; }
    public void setPetEnergy(Integer petEnergy) { this.petEnergy = petEnergy; }

    public LocalDateTime getPetLastActive() { return petLastActive; }
    public void setPetLastActive(LocalDateTime petLastActive) { this.petLastActive = petLastActive; }

    public Integer getPetStage() { return petStage; }
    public void setPetStage(Integer petStage) { this.petStage = petStage; }
}
