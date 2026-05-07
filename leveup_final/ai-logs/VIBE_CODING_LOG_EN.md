# Vibe Coding Logs - LevelUp Fitness App
## Project Overview

**Project Name**: LevelUp - Fitness Tracking & Pet Raising App
**Tech Stack**: Spring Boot + Thymeleaf + JPA/Hibernate + MySQL + Canvas API
**Core Features**: User authentication, workout logging, diet tracking, weight management, pet companion system

---

## 1. Project Initialization

### Prompt 1: Project Setup
```
I need to create a Spring Boot project with the following features:
- User registration and login (email + password, BCrypt encryption)
- Workout logging (training, diet)
- Thymeleaf as template engine
- MySQL database
- JPA/Hibernate for data persistence

Please help me create the complete project structure and base code.
```

---

## 2. User Authentication System

### Prompt 2: User Registration Page
```
Create registration page signup.html:
1. Email input (for login)
2. Password input (min 8 characters)
3. Confirm password
4. Name input
5. Gender selection (male/female)
6. Password stored with BCrypt encryption
7. Form validation and error messages
8. After successful registration, redirect to welcome or setup page
```

### Prompt 3: User Login Page
```
Create login page signin.html:
1. Email input
2. Password input
3. Login button
4. Error messages (email not found, wrong password)
5. "Forgot password" link (optional)
6. "No account? Sign up" link
7. Save user session on successful login
8. Password visibility toggle feature
```

### Prompt 4: Authentication Controller
```
Create AuthController for authentication:
1. GET /signup - Show registration page
2. POST /signup - Handle registration, validate email uniqueness
3. GET /signin - Show login page
4. POST /signin - Handle login, verify credentials
5. POST /signout - Logout, destroy session
6. Use Spring Security or native session for user state management
```

---

## 3. User Profile & Body Data

### Prompt 5: Welcome & Initial Setup
```
Create welcome page welcome.html:
1. Welcome message and app introduction
2. Guide user to fill in basic body data:
   - Height (cm)
   - Weight (kg)
   - Age
   - Gender
3. After submission, redirect to goal setting
```

### Prompt 6: User Entity Design
```
Add the following fields to User entity:
- id (Long, primary key)
- email (String, unique)
- name (String)
- password (String, BCrypt encrypted)
- height (Float)
- weight (Float)
- age (Integer)
- gender (String)
- goal (String)
- trainingFrequency (Double)
- xp (Integer, default 0)
- streakDays (Integer, default 0)
- tdee (Integer)

Add complete getter/setter methods and JPA annotations.
```

---

## 4. TDEE & Goal Calculation

### Prompt 7: TDEE Calculation Service
```
Implement Total Daily Energy Expenditure calculation:
1. Use Mifflin-St Jeor formula for BMR
   Male: BMR = 10×weight(kg) + 6.25×height(cm) - 5×age + 5
   Female: BMR = 10×weight(kg) + 6.25×height(cm) - 5×age - 161
2. Apply activity multiplier for TDEE
   Sedentary (little exercise): BMR × 1.2
   Lightly active (1-3 days/week): BMR × 1.375
   Moderately active (3-5 days/week): BMR × 1.55
   Very active (6-7 days/week): BMR × 1.725
3. Implement calculateTDEE() in UserService
4. Auto-recalculate TDEE when user data is updated
```

### Prompt 8: Goal Setting Page
```
Create goal setting page goal.html:
1. User selects fitness goal:
   - Lose fat (intake < TDEE - 500)
   - Gain muscle (intake > TDEE + 300)
   - Maintain (intake = TDEE)
2. Set target weight
3. Calculate recommended daily calorie intake
4. Show estimated time to reach goal
5. Store goal in user's goal field
```

### Prompt 9: Training Frequency Setting
```
Create training frequency page frequency.html:
1. User selects weekly training days (1-7 days)
2. Adjust activity multiplier based on frequency
3. Show recommended weekly training volume
4. Store in user trainingFrequency field
5. Recalculate TDEE after update
```

---

## 5. Diet Tracking System

### Prompt 10: Diet Log Page
```
Create diet log page diet.html:
1. Display today's diet records list
2. Add food entries:
   - Food name
   - Calories (kcal)
   - Protein (g)
   - Carbohydrates (g)
   - Fat (g)
3. Show today's total calorie intake
4. Compare with user's TDEE, show remaining calories
5. Categorize by meals: breakfast, lunch, dinner
6. Support custom food input
7. Responsive card layout
```

### Prompt 11: Food Data Management
```
Create food data management:
1. Food entity: id, name, calories, protein, carbs, fat, servingSize
2. FoodRepository supports search by name
3. DietService provides:
   - addFoodRecord()
   - getTodayDiet()
   - calculateTotalCalories()
   - getFoodSuggestions()
```

---

## 6. Workout Plan System

### Prompt 12: Workout Page
```
Create workout page workouts.html:
1. Display today's workout plan
2. Select different workout types (HIIT, strength, yoga, running, etc.)
3. Show each exercise details:
   - Exercise name
   - Sets
   - Reps
   - Weight (optional)
   - Rest time
4. Mark workout as complete
5. Display streak days
6. Click "Start Workout" to begin timer
```

### Prompt 13: Workout Template System
```
Implement workout template:
1. WorkoutTemplate entity: id, name, description, category
2. TemplateExercise entity: templateId, name, sets, reps, restSeconds
3. Pre-built templates:
   - Chest workout
   - Back workout
   - Leg workout
   - HIIT Fat Burn
   - Yoga Relax
4. Generate workout plan from template
5. Support custom exercise input
```

### Prompt 14: Workout Completion Flow
```
Implement workout completion flow:
1. User clicks "Complete Workout" button
2. Record completion time and duration
3. Save workout record to workout_plan table
4. Add user XP (base XP + streak bonus)
5. Update streakDays
6. Check achievement unlock conditions
7. Trigger pet onWorkoutComplete() update
8. Redirect to finish page with animation
```

---

## 7. Streak & Level System

### Prompt 15: Streak Days Tracking
```
Implement streak tracking:
1. Check time interval since last workout on completion
2. If > 48 hours passed, reset streakDays to 1
3. If within 48 hours, streakDays++
4. Streak affects:
   - XP bonus (higher streak = higher bonus, max +20)
   - Pet mood bonus
5. Reset to 1 on break
```

### Prompt 16: User Level System
```
Implement user level system:
1. Level up every 100 XP
2. Formula: level = (xp / 100) + 1
3. Complete workout to gain XP (base 20 + streak bonus)
4. Display level and progress bar on homepage
5. Show golden glow animation on level up
6. Create XpResult DTO returning:
   - currentXp
   - xpForNextLevel
   - level
   - showAnimation
   - isLevelUp
```

---

## 8. Weight Management

### Prompt 17: Weight Logging
```
Add weight logging to person.html:
1. Display current weight and goal weight
2. Calendar view showing daily weight records
3. Click today to log new weight
4. Show weight change trend (vs previous day)
5. Weight data stored in WeightLog table
6. Browse historical records by month
7. Color coding: decrease=green, increase=red
```

### Prompt 18: Weight Data Service
```
Create weight data management:
1. WeightLog entity: id, userId, date, weight
2. WeightLogService provides:
   - addWeight(userId, date, weight)
   - getMonthData(userId, year, month)
   - getLatestWeight(userId)
3. Calculate weight change: current - previous
4. Validate weight range (20-300kg)
```

---

## 9. Achievement & Trophy System

### Prompt 19: Trophy Room Page
```
Create trophy room page trophy.html:
1. Display user's earned achievement trophies
2. Achievement categories:
   - Workout count (first, 10, 50, 100 times)
   - Streak days (7, 30, 100 days)
   - Weight goal achieved
   - Level reached (level 5, 10)
3. Each trophy shows:
   - Icon
   - Name
   - Description
   - Obtained date
4. Locked trophies shown as grey
5. Display earned/total trophy count
```

### Prompt 20: Achievement Unlock Logic
```
Implement achievement unlock system:
1. Trophy entity: id, name, description, iconType, unlockType, unlockValue
2. UserTrophy entity: id, userId, trophyId, obtainedAt
3. AchievementService checks unlock conditions:
   - WORKOUT_COUNT - workout count reached
   - STREAK_DAYS - streak days reached
   - WEIGHT_GOAL - target weight achieved
   - LEVEL_REACH - level reached
4. Show popup notification on unlock
5. Check all achievements after workout completion
```

---

## 10. Pet Companion System

### Prompt 21: Pet System Requirements
```
I want to add a pet system to the app with these requirements:
1. Draw pets using Canvas (no images)
2. 4 elemental types: fire, water, grass, electric
3. Each element has unique color scheme and appearance
4. 4 appearance stages: Baby(0), Teen(1), Adult(2), Full Grown(3)
5. Pets gain experience and level up by completing workouts
6. Pets have mood (0-100) and energy (0-100)
7. No feeding system needed
8. One pet per user

Please design database fields, Java entity, Service layer and Controller layer.
```

### Prompt 22: Canvas Pet Drawing
```
Create Canvas drawing function drawPet() for pets:
1. Use different colors based on element type (fire/water/grass/electric)
2. Show different expressions based on mood:
   - Happy: mood > 50
   - Neutral: 20 ≤ mood ≤ 50
   - Sad: mood < 20
3. Display energy indicator based on energy value (sparkle effect)
4. Pet has breathing animation effect (slight up/down float)
5. Support different appearance stages:
   - Stage 0 (Baby): smaller body, round ears
   - Stage 1 (Teen): larger body
   - Stage 2 (Adult): full size
   - Stage 3 (Full Grown): largest size
6. Function receives parameters: canvasId, width, height, petStage, animate
```

### Prompt 23: Pet Evolution System
```
Implement pet evolution system:
1. Evolution requirements:
   - Stage 0 (Baby) needs level 5 to evolve to stage 1 (Teen)
   - Stage 1 (Teen) needs level 10 to evolve to stage 2 (Adult)
   - Stage 2 (Adult) is max stage, cannot evolve further
2. Evolution is manually triggered (user clicks button), not automatic
3. Pet appearance changes after evolution (bigger, more mature)
4. Play animation during evolution
5. Implement shouldEvolve() and evolvePet() methods in PetService
```

### Prompt 24: Pet Selection Page
```
Create pet selection page pet-choose.html:
1. Show preview cards for 4 pet types
2. Each pet shows Canvas-drawn preview animation
3. Confirm button enabled after selection
4. Redirect to /pet/choose POST endpoint after confirmation
5. Use dark gradient background
6. Responsive layout for mobile
```

### Prompt 25: Pet Main Page
```
Create pet main page pet.html:
1. Display current pet status:
   - Level
   - Experience progress bar
   - Mood value
   - Energy value
   - Current stage name
2. Canvas draw large pet image with breathing animation
3. Experience progress bar showing exp needed for next level
4. Show "Evolve" button when evolution requirements are met
5. Evolution button click shows evolution animation modal
6. Bottom navigation bar
```

### Prompt 26: Evolution Animation & Modal
```
Add evolution functionality to pet page:
1. Show modal popup after clicking "Evolve" button
2. Modal displays evolution animation (pet growing process)
3. Show new appearance pet after evolution completes
4. Auto close modal and refresh page state after evolution
5. Use fetch API to call backend /pet/evolve endpoint
6. Update session user data after successful evolution
```

### Prompt 27: Workout Completion Triggers Pet Update
```
When user completes a workout, update pet status:
1. Add pet experience (base 20 + streak bonus, max +20)
2. Increase pet mood (+10)
3. Decrease pet energy (-30)
4. Check for level up (exp reaches threshold)
5. Do NOT trigger evolution (evolution requires manual click)
6. Update petLastActive timestamp

Implement onWorkoutComplete() method in PetService
```

### Prompt 28: Mood Decay & Energy Recovery
```
Implement pet daily status changes:
1. Mood decay: -20 mood per 24 hours of inactivity
2. Energy recovery: +10 energy per 6 hours
3. Calculate and apply these changes when user visits pet page
4. Update petLastActive timestamp

Implement updateMoodDecay() and recoverEnergy() methods in PetService
```

### Prompt 29: Homepage Pet Card
```
Add pet card to homepage:
1. Card background uses gradient color
2. Display pet level and mood value
3. Canvas draw mini pet animation
4. Click card to navigate to /pet page
5. Do not show this card if user doesn't have a pet yet

Use Thymeleaf conditional rendering: th:if="${user.petType != null}"
```

---

## 11. Homepage & Navigation

### Prompt 30: Homepage Layout
```
Create homepage.html:
1. Top logo area
2. Today's workout big card (click to enter workout page)
3. Two-column card layout:
   - Diet card (click to enter diet page)
   - Trophy card (click to enter trophy room)
4. Pet card (if user has pet, click to enter pet page)
5. User level progress bar
6. Bottom navigation bar:
   - Home (current)
   - Explore
   - Profile
```

### Prompt 31: Explore Page
```
Create explore.html:
1. Show recommended workout templates
2. Show popular diet records
3. Show weekly workout statistics
4. Recommend next workout goal
5. Fitness tips
```

### Prompt 32: Profile Page
```
Create profile page person.html:
1. User avatar and basic info
2. Weight log calendar view
3. Today's recommended workout
4. Fitness statistics:
   - Best streak days
   - Total workout count
   - Current level
5. Goal progress display
```

---

## 12. Code Quality Improvements

### Prompt 33: Add Professional English Comments
```
Add professional English comments to all code:
1. No Chinese comments
2. Javadoc-style comments
3. Each method has clear function description
4. Important logic has inline comments
5. Constant arrays have index explanations

Files to improve:
- User.java (user entity fields)
- UserService.java (TDEE calculation, etc.)
- DietService.java (diet management)
- WorkoutService.java (workout management)
- PetService.java (pet business logic)
- PetController.java (pet controller)
- person.html (weight logging JS)
- homepage.html (homepage JS)
- pet.html (pet page JS)
```

---

## 13. Issue Fixes

### Issue 1: Array Index Out of Bounds
**Problem**: LEVEL_EXP_THRESHOLDS[20] causes ArrayIndexOutOfBoundsException
**Cause**: Array max index is 19 (Level 20), but code tries to access index 20
**Fix**: Changed `nextThreshold = LEVEL_EXP_THRESHOLDS[20]` to `nextThreshold = 9500`

### Issue 2: Level 1 Can Evolve Unlimited Times
**Problem**: Even pets with level 1 can evolve 3 times
**Cause**: shouldEvolve() and evolvePet() didn't check both level and stage together
**Fix**:
- stage=0 requires level >= 5 to evolve
- stage=1 requires level >= 10 to evolve
- stage >= 2 cannot evolve

### Issue 3: Evolution Modal Shows Repeatedly
**Problem**: Evolution modal appears every time user logs in and visits pet page
**Cause**: Modal display logic only checked shouldEvolve(), no persistence handling
**Fix**: Evolution changed to manual trigger, not auto-checked on page load

### Issue 4: Canvas Shows Black Ball
**Problem**: Page shows a "breathing black ball" when loading
**Cause**: Duplicate stage variable declaration in JavaScript, or drawing logic error
**Fix**: Removed duplicate stage declaration, ensured Canvas initializes correctly

---

## 14. Key Design Decisions

1. **Canvas vs Images**: Choose Canvas for pet drawing, avoids static image resources, smoother animations
2. **Manual Evolution**: User must actively click evolution button, enhances interaction and sense of achievement
3. **Mood Decay**: Incentivizes users to maintain training habits, pets get sad without workouts
4. **Energy Consumption**: Simulates real workout exhaustion, adds gamification element
5. **No Feeding System**: Simplifies system complexity, focuses on core fitness features
6. **BCrypt Password Encryption**: Secure password storage
7. **Session Management**: Use HttpSession to store login state

---

## 15. File Structure

```
src/main/java/com/example/demo/
├── entity/
│   ├── User.java              # User entity
│   ├── Food.java              # Food data entity
│   ├── Exercise.java          # Exercise entity
│   ├── WorkoutPlan.java       # User workout plan entity
│   ├── WorkoutExercise.java   # Completed exercise record
│   ├── WorkoutTemplate.java   # Workout template
│   ├── TemplateExercise.java  # Template exercise
│   ├── Trophy.java            # Trophy/achievement definition
│   ├── UserTrophy.java        # User's earned trophies
│   └── WeightLog.java         # Weight log
├── dto/
│   ├── FoodDto.java           # Food data transfer object
│   ├── ExerciseDto.java       # Exercise DTO
│   └── XpResult.java          # XP calculation result DTO
├── repository/
│   ├── UserRepository.java
│   ├── FoodRepository.java
│   ├── ExerciseRepository.java
│   ├── WorkoutPlanRepository.java
│   ├── WorkoutExerciseRepository.java
│   ├── WorkoutTemplateRepository.java
│   ├── TemplateExerciseRepository.java
│   ├── TrophyRepository.java
│   ├── UserTrophyRepository.java
│   └── WeightLogRepository.java
├── service/
│   ├── UserService.java       # User business (TDEE calculation)
│   ├── DietService.java       # Diet management
│   ├── WorkoutService.java     # Workout management
│   ├── AchievementService.java # Achievement unlock
│   ├── WeightLogService.java   # Weight logging
│   └── PetService.java        # Pet system
└── controller/
    ├── AuthController.java     # Registration/login
    ├── DietController.java     # Diet page
    ├── WorkoutController.java  # Workout page
    ├── PetController.java      # Pet page
    └── ...

src/main/resources/
├── templates/
│   ├── signin.html            # Login page
│   ├── signup.html            # Registration page
│   ├── welcome.html           # Welcome page
│   ├── goal.html              # Goal setting
│   ├── frequency.html         # Training frequency
│   ├── homepage.html          # Home page
│   ├── explore.html           # Explore page
│   ├── person.html           # Profile page
│   ├── workouts.html          # Workout page
│   ├── templates.html         # Workout templates
│   ├── diet.html              # Diet log
│   ├── trophy.html            # Trophy room
│   ├── pet.html              # Pet main page
│   └── pet-choose.html       # Pet selection
└── static/
    └── css/
        ├── globals.css
        └── styleguide.css
```

---

## 16. Database Fields

### users table
```sql
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    height FLOAT,
    weight FLOAT,
    age INT,
    gender VARCHAR(10),
    goal VARCHAR(50),
    training_frequency DOUBLE,
    xp INT DEFAULT 0,
    streak_days INT DEFAULT 0,
    tdee INT,
    pet_type VARCHAR(20),
    pet_level INT DEFAULT 1,
    pet_exp INT DEFAULT 0,
    pet_mood INT DEFAULT 100,
    pet_energy INT DEFAULT 100,
    pet_last_active DATETIME,
    pet_stage INT DEFAULT 0
);
```

### food table
```sql
CREATE TABLE food (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    calories INT,
    protein FLOAT,
    carbs FLOAT,
    fat FLOAT,
    serving_size VARCHAR(50)
);
```

### trophy table
```sql
CREATE TABLE trophy (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    icon_type VARCHAR(50),
    unlock_type VARCHAR(50),
    unlock_value INT
);
```

### user_trophy table
```sql
CREATE TABLE user_trophy (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    trophy_id BIGINT,
    obtained_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (trophy_id) REFERENCES trophy(id)
);
```

### weight_log table
```sql
CREATE TABLE weight_log (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    date DATE,
    weight FLOAT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### workout_template table
```sql
CREATE TABLE workout_template (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    category VARCHAR(50)
);
```

### template_exercise table
```sql
CREATE TABLE template_exercise (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    template_id BIGINT,
    name VARCHAR(100),
    sets INT,
    reps INT,
    rest_seconds INT,
    FOREIGN KEY (template_id) REFERENCES workout_template(id)
);
```

### workout_plan table
```sql
CREATE TABLE workout_plan (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    date DATE,
    template_id BIGINT,
    completed BOOLEAN DEFAULT FALSE,
    duration_minutes INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (template_id) REFERENCES workout_template(id)
);
```

### workout_exercise table
```sql
CREATE TABLE workout_exercise (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    plan_id BIGINT,
    exercise_name VARCHAR(100),
    sets_completed INT,
    reps_completed INT,
    weight FLOAT,
    FOREIGN KEY (plan_id) REFERENCES workout_plan(id)
);
```

---

## 17. Feature Flow Charts

### User Registration Flow
```
Registration Page → Fill email/password → Submit → Validate email unique → BCrypt encrypt → Create user → Redirect to welcome
```

### First-Time Setup Flow
```
Welcome Page → Fill body data → Submit → Calculate BMR → Goal setting → Select goal → Set frequency → Redirect to homepage
```

### Daily Usage Flow
```
Homepage → Start workout → Complete → Gain XP → Update streak → Check level up → Update pet → Check achievements → Return to homepage
```

### Pet Evolution Flow
```
Pet Page → Check evolution conditions → Show evolve button → Click evolve → Call API → Update petStage → Show animation → Refresh page
```

---

*Document generated: 2026-05-06*
*Based on Vibe Coding philosophy: AI as programming partner, rapid iteration to implement features*
