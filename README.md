texcollab
=========

A LaTeX/Git wrapper for the "Advisor-Student/s Mergeless" model written
entirely in shell script. I work on an up to date Arch Linux machine and I
suppose the compatibility should be okay, but you will obviously need `git`,
`openssh`, `rsync`, and `latex` (we use `texlive`). If you have issues, please ask me,
but I can't guarantee I can help with everything. I don't imply any warranty
with this script! It has worked for me, but I guarantee nothing.

# Why does this exist?

`git merge` works perfectly fine for source code, but LaTeX is not quite like
source code. Our group attempted to switch to a `git` workflow previously, but
found it to be too difficult for beginners. I decided to step in and fix the
problem by simplifying and developing a standard collaboration workflow.

# What the heck is the "Advisor-Student/s Mergeless" model?

As I said, I dislike `git merge` for LaTeX and I need a simple workflow for
everyone involved with the project. So, the model consists of the `master`
branch (your advisor's branch!) and a branch for each "student" (I will refer
to myself as the student i.e. the `barrymoo` branch). The student is never
allowed to commit to `master` and my advisor is never allowed to commit to
`barrymoo`. Neither the student nor the advisor will ever `texcollab merge`
(note it doesn't exist!).

# SSH Config

We assume you have ssh access to a private server to store the git remote
repository. Additionally, you should set up password-less login to that server.
Finally, we suggest to use `.ssh/config` to ease the process.
Googling "ssh config" yields [Simplify Your Life With an SSH Config 
File](http://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/).
The link should be enough to get you started.

# How can I use this model?

It's pretty easy, I promise.

First, you need to set up some configuration variables inside `.texcollab` (see
the one in this repo as an example). My group uses this tool for publications
which means a public github really isn't a great idea. We have storage on a
remote machine with `ssh` access, that domain is in `TEXCOLLAB_REMOTE_DOMAIN`.
On the remote machine exists a place where I put my "in-progress" publications,
something like `/$SOME_PATH/shared/latex/barrymoo/$PROJECT_NAME`, which I set
as `TEXCOLLAB_REMOTE_DIR` (obviously all but the `$PROJECT_NAME` should already
exist!). The project name should be unique and will be stored on the remote
machine as `$PROJECT_NAME.git` (a standard style for git remote repos). Next,
you should set your advisors and your user name for
`TEXCOLLAB_ADVISOR/TEXCOLLAB_STUDENT`, respectively. The
`TEXCOLLAB_CURRENT_USER` can be set to `$TEXCOLLAB_ADVISOR` or
`$TEXCOLLAB_STUDENT` (note the `$`) and the `TEXCOLLAB_EDITOR` is used for the
`view` command.

Now you're ready to initialize the directory! Place your `*.tex` file, `*.bib`
files (if necessary), and figures to the `figures` directory (Always use
`supporting-information.tex` for supporting information). Run `texcollab init`,
if you have figures run `texcollab figures push` (additionally), and let the
git magic ensue :) Note, that `texcollab compile` exists and you should
probably make sure it compiles properly before sending it to your advisor (they
hate when it doesn't compile right!). 

# How does my advisor use this model?

Also easy!

Remember, first, that the advisor always uses the master branch. You, the
student, will send him/her the `.texcollab` file. The advisor will navigate to
wherever they want the local copy and run `texcollab clone
$TEXCOLLAB_REMOTE_DOMAIN:$TEXCOLLAB_REMOTE_DIR` (note lack of `.git` ending).
They will need to enter this manually, the environment variables are not
available outside the script unless you make them available. 

Once the clone is complete, the advisor would navigate to the new local git
repository and modify `TEXCOLLAB_CURRENT_USER` to `$TEXCOLLAB_ADVISOR`, and
other environment setting they choose. If you have figures run `texcollab
figures pull`, they need to run `texcollab branch $TEXCOLLAB_STUDENT` (again,
enter student manually) to make the student branch visible (git doesn't do this
automatically), and `texcollab compile`. Voila!

# What do I do now, how do we share commits?

Again, easy :P I hope you see the pattern now.

Both the student and advisor can make changes willy-nilly! Commit, push, pull,
figures push/pull, etc. When the advisor, or student, are ready to "merge"
changes run `texcollab compare main.tex barrymoo` (`main.tex` of `master` with
`main.tex` of `barrymoo`, for example), this will open up the
`TEXCOLLAB_MERGE_TOOL` (we use meld) and then one can pick and choose the
changes (or don't!). Finally, commit/push and the other collaborator is ready
to pull. I also added a `texcollab log` functionality, which means you can use
the config key to compare with previous commits too (see `-h/--help`)

# Cool, how do I add collaborators?

Pass the collaborator the `.texcollab`, have them change the
`TEXCOLLAB_STUDENT` variable, clone the repository as the advisor does, and
`texcollab add-collab $TEXCOLLAB_STUDENT` (the `$TEXCOLLAB_STUDENT` is 
obviously the new collaborator). The collaborator can now edit/commit/push/pull
as normal now. AND, more importantly (arguably), the advisor can pull and `texcollab
branch $NEW_STUDENT_BRANCH` to "merge" changes from both students.

# `view` and `compare`, what's a revision?

In the `-h/--help` string, you may see that `view` and `compare` work with revisions,
but what is a revision? A revision is basically a previous commit's version of the file
of interest. The best way to get this information is to run `texcollab log`, for example:

```
commit 45f158b34cef9141aaeacebc09f37ff800071132
Author: Jon Doe
Date: Tue Jun 2 11:54:07 2015

    Initial Commit
```

The revision is: `45f158b34cef9141aaeacebc09f37ff800071132`, copy and paste the string
to `compare` and `view` to use the revision.

# Anything else?

This is a work-in-progress and I haven't done much testing as of yet. Please send
me issues, or suggestions, here on github. I am very interested in making a
nice collaboration tool for everyone. Feel free to fork, and submit pull
requests :). 
