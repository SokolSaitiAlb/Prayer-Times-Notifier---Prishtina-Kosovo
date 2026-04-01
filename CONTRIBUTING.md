# Contributing to Prayer Times Notifier 🤝

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing to this project.

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Help others and share knowledge
- Report issues responsibly

## Ways to Contribute

### 1. Report Bugs 🐛

Found a bug? Help us fix it!

**Create an issue:**
- Go to [Issues](https://github.com/yourusername/prayer-times-notifier/issues)
- Click "New Issue"
- Provide:
  - **Title:** Brief description of the bug
  - **Description:** What happened, what you expected
  - **Steps to reproduce:** How to trigger the bug
  - **Environment:** 
    ```bash
    uname -a                    # OS info
    bash --version              # Bash version
    jq --version                # jq version
    curl --version              # curl version
    ```
  - **Logs/Output:** Any error messages

### 2. Suggest Features 💡

Have a great idea? We'd love to hear it!

**Create a feature request:**
- Go to [Issues](https://github.com/yourusername/prayer-times-notifier/issues)
- Click "New Issue"
- Title: "Feature: [Brief description]"
- Describe:
  - What you want to add
  - Why it would be useful
  - How it might work

### 3. Improve Documentation 📚

Documentation improvements are always welcome!

**Areas for improvement:**
- Clearer explanations in README
- Additional examples
- Translations to other languages
- Better inline code comments

**To contribute:**
1. Fork the repository
2. Edit `.md` files
3. Submit a pull request

### 4. Contribute Code 💻

Want to add new features or fix bugs?

## Development Workflow

### 1. Fork the Repository

```bash
# Click "Fork" on GitHub, then:
git clone https://github.com/YOUR_USERNAME/Prayer-Times-Notifier---Prishtina-Kosovo.git
cd Prayer-Times-Notifier---Prishtina-Kosovo
```

### 2. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/bug-name
```

**Branch naming:**
- `feature/feature-name` - New features
- `fix/bug-name` - Bug fixes
- `docs/documentation-update` - Documentation
- `refactor/code-improvement` - Code refactoring

### 3. Make Your Changes

**Code Style Guidelines:**

- Follow standard bash conventions
- Add comments for complex logic
- Keep functions focused and small
- Use meaningful variable names

**Example:**
```bash
# Good: Clear, commented, focused
get_prayer_time() {
    local prayer=$1
    # Extract specific prayer time from response
    echo "$prayers" | jq -r ".${prayer}"
}

# Avoid: Unclear, no comments, too complex
gpt() {
    echo "$p" | jq -r ".$1"
}
```

### 4. Test Your Changes

```bash
# Run the script with your changes
./prayer_times.sh

# Test with different parameters
CITY="Prishtina" COUNTRY="Kosovo" ./prayer_times.sh

# Check for bash syntax errors
bash -n prayer_times.sh
```

### 5. Commit Your Changes

```bash
git add .
git commit -m "feature: Add [description of changes]"
```

**Commit message format:**
- `feature: Add [feature name]`
- `fix: Resolve [bug description]`
- `docs: Update [section name]`
- `refactor: Improve [component name]`
- `test: Add tests for [component]`

### 6. Push and Create Pull Request

```bash
git push origin feature/your-feature-name
```

**Then:**
1. Go to GitHub
2. Click "Compare & pull request"
3. Fill in the PR template:
   - **What:** Brief description
   - **Why:** Why this change is needed
   - **How:** How the change works
   - **Tests:** How to test the change
   - **Fixes:** Closes #(issue number) if applicable

---

## Priority Features for Contribution

These features would significantly improve the project:

### High Priority ⭐⭐⭐
- [x] **KDE Plasma 6 Support** ✅
  - Use `kdialog` for native system tray notifications
  - Auto-detect KDE Plasma environment
  - Tested and working

- [ ] **macOS Support**
  - Replace `notify-send` with `terminal-notifier`
  - Add platform detection in script
  - Test on multiple macOS versions

- [ ] **Multiple Cities Support**
  - Accept city as command-line argument
  - Store user preferences
  - Support multiple timezones

### Medium Priority ⭐⭐
- [ ] **Voice Notifications**
  - Use `espeak` or `festival` for voice
  - Make it optional
  - Test with different voices

- [ ] **Web Interface**
  - Simple HTML/CSS dashboard
  - Display next prayer countdown
  - Show prayer times for the week
  
- [ ] **Multi-Distribution Testing**
  - Ensure compatibility with Arch, Fedora, Debian, NixOS, Alpine
  - Automated testing for each distro
  - CI/CD pipeline

### Low Priority ⭐
- [ ] **Email Notifications**
- [ ] **Slack Integration**
- [ ] **Quranic Ayah Display**
- [ ] **Hijri Calendar Conversion**

---

## Testing Checklist

Before submitting a PR, test:

- [ ] Script runs without errors: `./prayer_times.sh`
- [ ] Bash syntax is valid: `bash -n prayer_times.sh`
- [ ] Notifications appear correctly
- [ ] Prayer times display correctly
- [ ] Works with different configurations
- [ ] Documentation is updated
- [ ] No hardcoded paths (use variables)
- [ ] Compatible with bash 5.0+

---

## Pull Request Process

1. **Update** the README.md with any new features
2. **Test** thoroughly on your system
3. **Reference** related issues
4. **Keep** commits clean and descriptive
5. **Wait** for review and feedback

**Merging:**
- Requires at least 1 approval
- All tests must pass
- No conflicts with main branch

---

## Code Review Guidelines

### For Contributors
When receiving feedback:
- Listen with an open mind
- Ask for clarification if needed
- Iterate on feedback
- Thank reviewers

### For Reviewers
When reviewing code:
- Be constructive and kind
- Explain your reasoning
- Suggest improvements, not demands
- Approve when satisfied

---

## Documentation Standards

### Inline Comments
```bash
# BAD: Not helpful
x=1  # x equals 1

# GOOD: Explains why
NOTIFICATION_DELAY=1  # Allow time for API response before checking
```

### Function Documentation
```bash
# Function: fetch_prayer_times
# Description: Fetches prayer times from Adhan API for given date
# Parameters:
#   $1 - Date in DD-MM-YYYY format
# Returns:
#   JSON response from API
fetch_prayer_times() {
    local date=$1
    curl -s "http://api.aladhan.com/v1/timingsByCity/$date?..."
}
```

---

## Release Process

Maintainers only:

```bash
# Update version in script
# Update CHANGELOG.md
# Create git tag
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

---

## Getting Help

- **Questions:** Open an [issue](https://github.com/yourusername/prayer-times-notifier/issues) with `[QUESTION]` tag
- **Documentation:** Check [README.md](README.md) and [QUICK_START.md](QUICK_START.md)
- **Discussions:** Use [GitHub Discussions](https://github.com/yourusername/prayer-times-notifier/discussions)

---

## Recognition

Contributors will be:
- ✨ Listed in [CONTRIBUTORS.md](CONTRIBUTORS.md)
- 🎉 Mentioned in release notes
- ⭐ Given credit in README

---

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

## Questions?

Feel free to reach out! Open an issue and tag it with `[QUESTION]`.

**Happy contributing! 🎉**
