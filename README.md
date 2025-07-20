# Ruby on Rails Microblogging App (Sample Application)

This is a Twitter-style microblogging web application built using **Ruby on Rails**. It supports full user authentication, account activation via email, micropost creation, user relationships (follow/unfollow), and a personalized timeline.

This project was completed by following the excellent  
[*Ruby on Rails Tutorial: Learn Web Development with Rails*](https://www.railstutorial.org/) by [Michael Hartl](https://www.michaelhartl.com/).

---

## What I Learned

As part of this tutorial, I gained hands-on experience with:
- Rails MVC architecture and RESTful routes
- Authentication and user session management
- Email activation and password reset via Action Mailer
- Model associations and validations
- Integration and unit testing using **Minitest**
- Deployment-readiness concepts

---

## Development Environment (DevContainer)

To ensure a consistent and reproducible development experience, I set up the project using **DevContainer** (Docker + VS Code Remote Containers). This removes system dependency issues and allows quick onboarding on any machine.

DevContainer setup repository:  
[https://github.com/Bobby-Zhu/learnenough-ruby-on-rails-devcontainer](https://github.com/Bobby-Zhu/learnenough-ruby-on-rails-devcontainer)

Features:
- Ruby 3, Rails 7, Node.js, PostgreSQL, and Yarn pre-installed
- Auto-load of environment via `.devcontainer/devcontainer.json`
- Pre-configured for debugging and terminal access in VS Code

---

## Getting Started (Local Setup)

### 1. Clone the repository

```bash
git clone https://github.com/Bobby-Zhu/sample_app.git
cd sample_app
