---
title: Git And Github
---

## 🧰 Basic Git Commands

### 1. **Configuration**

Set up your identity for all repositories on your system:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

To check your configuration:

```bash
git config --list
```

### 2. **Initialize a Repository**

Start a new Git repository in your current directory:

```bash
git init
```

### 3. **Clone a Repository**

Create a local copy of a remote repository:

```bash
git clone <repository_url>
```

### 4. **Check Status**

View the status of your files in the working directory and staging area:

```bash
git status
```

### 5. **Add Files**

Add specific files to the staging area:

```bash
git add <file_name>
```

Add all changes in the current directory:

```bash
git add .
```

### 6. **Commit Changes**

Record changes to the repository with a message:

```bash
git commit -m "Your commit message"
```

### 7. **View Commit History**

See the commit history for the current branch:

```bash
git log
```

---

## 🌿 Branching and Merging

### 8. **List Branches**

Display all branches in your repository:

```bash
git branch
```

### 9. **Create a New Branch**

Create a new branch:

```bash
git branch <branch_name>
```

### 10. **Switch Branches**

Switch to another branch:

```bash
git checkout <branch_name>
```

### 11. **Create and Switch to a New Branch**

Create and switch to a new branch in one command:

```bash
git checkout -b <branch_name>
```

### 12. **Merge Branches**

Merge a branch into your current branch:

```bash
git merge <branch_name>
```

### 13. **Delete a Branch**

Delete a branch:

```bash
git branch -d <branch_name>
```

---

## 🔄 Remote Repositories

### 14. **Add Remote Repository**

Add a new remote repository:

```bash
git remote add origin <repository_url>
```

### 15. **View Remote URLs**

List all configured remote repositories:

```bash
git remote -v
```

### 16. **Push Changes**

Push your commits to the remote repository:

```bash
git push origin <branch_name>
```

### 17. **Pull Changes**

Fetch and merge changes from the remote repository:

```bash
git pull origin <branch_name>
```

### 18. **Set Upstream Branch**

Set the default remote branch for your current local branch:

```bash
git push --set-upstream origin <branch_name>
```

---

## 🧹 Undoing Changes

### 19. **Unstage a File**

Remove a file from the staging area:

```bash
git reset <file_name>
```

### 20. **Discard Changes in a File**

Revert changes in a file to the last committed state:

```bash
git checkout -- <file_name>
```

### 21. **Revert a Commit**

Create a new commit that undoes the changes from a previous commit:

```bash
git revert <commit_hash>
```

### 22. **Reset to a Previous Commit**

Reset your repository to a specific commit:

```bash
git reset --hard <commit_hash>
```

---

## 📦 Stashing Changes

### 23. **Stash Changes**

Temporarily save changes that are not ready to be committed:

```bash
git stash
```

### 24. **List Stashes**

View a list of stashed changes:

```bash
git stash list
```

### 25. **Apply Stashed Changes**

Reapply stashed changes to your working directory:

```bash
git stash apply
```

### 26. **Drop a Stash**

Remove a specific stash from the list:

```bash
git stash drop
```

---

## 🛠️ Advanced Commands

### 27. **Amend a Commit**

Modify the most recent commit:

```bash
git commit --amend
```

### 28. **Rebase Branches**

Reapply commits on top of another base tip:

```bash
git rebase <branch_name>
```

### 29. **Cherry-Pick a Commit**

Apply the changes from a specific commit:

```bash
git cherry-pick <commit_hash>
```

### 30. **Squash Commits**

Combine multiple commits into one:

```bash
git rebase -i HEAD~n
```

Replace `n` with the number of commits to squash.

---

## 🧾 Git Logs and Diffs

### 31. **Show Commit History**

Display a concise commit history:

```bash
git log --oneline
```

### 32. **Show Changes**

View changes between commits, branches, files, etc.:

```bash
git diff
```

### 33. **Show a Specific Commit**

Display information about a specific commit:

```bash
git show <commit_hash>
```

---

## 🧰 Miscellaneous Commands

### 34. **Rename a Branch**

Rename the current branch:

```bash
git branch -m <new_branch_name>
```

### 35. **Clean Untracked Files**

Remove untracked files from the working directory:

```bash
git clean -f
```

### 36. **Tagging**

Create a new tag:

```bash
git tag <tag_name>
```

Push tags to the remote repository:

```bash
git push origin <tag_name>
```

---

## 🔗 GitHub-Specific Commands

While GitHub primarily uses Git, it also offers additional features:

### 37. **Fork a Repository**

Create a personal copy of someone else's repository on GitHub.

### 38. **Create a Pull Request**

Propose changes to a repository by creating a pull request.

### 39. **GitHub CLI**

GitHub offers a command-line tool to interact with GitHub:

```bash
gh auth login
gh repo clone <repository>
gh issue list
gh pr create
```

---
![[git-cheat-sheet-education.pdf]]