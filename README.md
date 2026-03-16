<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>C3-3 · CPT208 Group</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: white;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            color: #1e293b;
            line-height: 1.5;
            padding: 2rem 1rem;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        h1 {
            font-size: 2.5rem;
            font-weight: 600;
            letter-spacing: -0.02em;
            margin-bottom: 0.5rem;
            color: #0f172a;
        }

        .subhead {
            font-size: 1.2rem;
            color: #475569;
            margin-bottom: 2.5rem;
            border-left: 4px solid #3b82f6;
            padding-left: 1rem;
        }

        h2 {
            font-size: 1.8rem;
            font-weight: 600;
            margin: 2.5rem 0 1.5rem;
            color: #0f172a;
            border-bottom: 2px solid #e2e8f0;
            padding-bottom: 0.5rem;
        }

        .goal-card {
            background: #f8fafc;
            border-radius: 1rem;
            padding: 1.8rem;
            margin-bottom: 2rem;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 6px -2px rgba(0,0,0,0.05);
        }

        .goal-card p {
            font-size: 1.2rem;
            color: #334155;
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .member-card {
            background: white;
            border-radius: 1rem;
            border: 1px solid #e2e8f0;
            padding: 1.8rem 1.2rem;
            text-align: center;
            transition: all 0.2s ease;
            box-shadow: 0 4px 6px -2px rgba(0,0,0,0.05);
        }

        .member-card:hover {
            box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }

        .avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #f1f5f9;
            margin-bottom: 1rem;
            background: #e2e8f0;
        }

        .member-name {
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .member-id {
            font-family: monospace;
            color: #64748b;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .member-role {
            color: #3b82f6;
            font-weight: 500;
            margin-bottom: 0.75rem;
        }

        .member-bio {
            color: #475569;
            font-size: 0.95rem;
        }

        .persona-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 2rem;
            margin-top: 1rem;
        }

        .persona-card {
            background: white;
            border-radius: 1rem;
            border: 1px solid #e2e8f0;
            overflow: hidden;
            box-shadow: 0 4px 6px -2px rgba(0,0,0,0.05);
        }

        .persona-header {
            background: #f1f5f9;
            padding: 1.5rem 1.5rem 1rem;
            text-align: center;
            border-bottom: 1px solid #e2e8f0;
        }

        .persona-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid white;
            margin-bottom: 0.75rem;
            background: #cbd5e1;
        }

        .persona-name {
            font-size: 1.6rem;
            font-weight: 600;
            line-height: 1.2;
        }

        .persona-age-occ {
            color: #475569;
            font-size: 1rem;
        }

        .persona-body {
            padding: 1.5rem;
        }

        .persona-section {
            margin-bottom: 1.2rem;
        }

        .persona-section h4 {
            font-size: 1rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #64748b;
            margin-bottom: 0.3rem;
        }

        .persona-section p {
            color: #1e293b;
        }

        hr {
            border: none;
            border-top: 1px solid #e2e8f0;
            margin: 0.5rem 0 1rem;
        }

        .footer {
            margin-top: 4rem;
            text-align: center;
            color: #94a3b8;
            font-size: 0.9rem;
            border-top: 1px solid #e2e8f0;
            padding-top: 2rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Group Header -->
        <h1>C3-3 · CPT208 Group</h1>
        <div class="subhead">
            Interaction Design · Discovering Requirements
        </div>

        <!-- Project Goal (Replace with your actual goal) -->
        <section>
            <h2>Project Goal</h2>
            <div class="goal-card">
                <p>📌 Develop an interactive platform that helps university students efficiently find study partners, share learning resources, and collaborate on academic projects in a distraction‑free environment.</p>
            </div>
        </section>

        <!-- Team Members -->
        <section>
            <h2>Team Members</h2>
            <div class="team-grid">
                <!-- Zicheng Niu -->
                <div class="member-card">
                    <img src="images/zicheng.jpg" alt="Zicheng Niu" class="avatar" onerror="this.src='https://via.placeholder.com/120'">
                    <div class="member-name">Zicheng Niu</div>
                    <div class="member-id">2362392</div>
                    <div class="member-role">Front-end Developer</div>
                    <div class="member-bio">Passionate about creating responsive and accessible interfaces.</div>
                </div>
                <!-- Weiyi Zheng -->
                <div class="member-card">
                    <img src="images/weiyi.jpg" alt="Weiyi Zheng" class="avatar" onerror="this.src='https://via.placeholder.com/120'">
                    <div class="member-name">Weiyi Zheng</div>
                    <div class="member-id">2361878</div>
                    <div class="member-role">UX Researcher</div>
                    <div class="member-bio">Enjoys conducting user interviews and translating insights into design.</div>
                </div>
                <!-- Linghui Zhu -->
                <div class="member-card">
                    <img src="images/linghui.jpg" alt="Linghui Zhu" class="avatar" onerror="this.src='https://via.placeholder.com/120'">
                    <div class="member-name">Linghui Zhu</div>
                    <div class="member-id">2363060</div>
                    <div class="member-role">UI Designer</div>
                    <div class="member-bio">Focused on visual design and prototyping with Figma.</div>
                </div>
                <!-- Mariia Starostina -->
                <div class="member-card">
                    <img src="images/mariia.jpg" alt="Mariia Starostina" class="avatar" onerror="this.src='https://via.placeholder.com/120'">
                    <div class="member-name">Mariia Starostina</div>
                    <div class="member-id">2583073</div>
                    <div class="member-role">Back-end Developer</div>
                    <div class="member-bio">Experienced in database management and API integration.</div>
                </div>
            </div>
        </section>

        <!-- User Personas (Replace with personas tailored to your project) -->
        <section>
            <h2>User Personas</h2>
            <div class="persona-grid">
                <!-- Persona 1 -->
                <div class="persona-card">
                    <div class="persona-header">
                        <img src="images/persona1.jpg" alt="Persona 1" class="persona-avatar" onerror="this.src='https://via.placeholder.com/100'">
                        <div class="persona-name">Wang Xiaoming</div>
                        <div class="persona-age-occ">22 · University Student (Computer Science)</div>
                    </div>
                    <div class="persona-body">
                        <div class="persona-section">
                            <h4>Background</h4>
                            <p>Third‑year undergrad who loves learning new tech skills through mobile apps. Active on online forums but finds them too noisy.</p>
                        </div>
                        <hr>
                        <div class="persona-section">
                            <h4>Goals</h4>
                            <p>Quickly find like‑minded study partners for coding projects and exam prep.</p>
                        </div>
                        <hr>
                        <div class="persona-section">
                            <h4>Pain Points</h4>
                            <p>Existing platforms are cluttered with irrelevant content; matching is imprecise and time‑consuming.</p>
                        </div>
                        <hr>
                        <div class="persona-section">
                            <h4>Behaviour</h4>
                            <p>Studies late at night, prefers minimalistic interfaces, and relies on push notifications.</p>
                        </div>
                    </div>
                </div>
                <!-- Persona 2 -->
                <div class="persona-card">
                    <div class="persona-header">
                        <img src="images/persona2.jpg" alt="Persona 2" class="persona-avatar" onerror="this.src='https://via.placeholder.com/100'">
                        <div class="persona-name">Li Fang</div>
                        <div class="persona-age-occ">35 · High School Teacher</div>
                    </div>
                    <div class="persona-body">
                        <div class="persona-section">
                            <h4>Background</h4>
                            <p>Busy teacher aiming to improve her teaching skills during spare time. Frequently uses a tablet for learning.</p>
                        </div>
                        <hr>
                        <div class="persona-section">
                            <h4>Goals</h4>
                            <p>Access high‑quality teaching resources and exchange ideas with fellow educators.</p>
                        </div>
                        <hr>
                        <div class="persona-section">
                            <h4>Pain Points</h4>
                            <p>Too little time to filter through massive content; needs personalised recommendations.</p>
                        </div>
                        <hr>
                        <div class="persona-section">
                            <h4>Behaviour</h4>
                            <p>Uses iPad during commute, prefers video tutorials and concise summaries.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <div class="footer">
            C3-3 · Interaction Design · 2026
        </div>
    </div>

    <!-- 
        INSTRUCTIONS:
        1. Create an 'images' folder in your repository.
        2. Place member photos as: zicheng.jpg, weiyi.jpg, linghui.jpg, mariia.jpg.
        3. Place persona photos as: persona1.jpg, persona2.jpg (or rename src accordingly).
        4. Update the project goal, member roles/bios, and persona details to match your actual project.
        5. Commit and push; your page will be available at https://<username>.github.io
    -->
</body>
</html>
