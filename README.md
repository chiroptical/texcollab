texcollab
=========

A LaTeX/Git wrapper for the "Advisor-Student/s Mergeless" model written entirely in shell script. I work on
an up to date Arch Linux machine and I suppose the compatability should be okay, but you
will obviously need `git`, `openssh`, and `latex` (we use `texlive`). If you have issues, please ask me, but
I can't guarentee I can help with everything. I don't imply any warranty with this script! It has worked for me,
but I gaurentee nothing.

# Why does this exist?

`git merge` works perfectly fine for source code, but LaTeX is not quite like source code. Our group attempted
to switch to a `git` workflow previously, but found it to be too difficult for beginners. I decided to step in
and fix the problem by simplifying and developing a standard collaboration workflow.

# What the heck is the "Advisor-Student/s Mergeless" model?

As I said, I dislike `git merge` for LaTeX and I need a simple workflow for new students. So, the model consists
of the `master` branch (advisor) and a branch for each "student" (I will refer to myself as the student i.e. the
`barrymoo` branch). The student is never allowed to commit to `master` and my advisor is never allowed to commit
to `barrymoo`. Neither the student nor the advisor will ever `texcollab merge` (note it doesn't exist!).

# How can I use this model?

It's pretty easy, I promise. First, you need to set up some configuration variables inside `.texcollab` (see
the one in this repo as an example). My group uses this tool for publications which means a public github really
isn't a great idea. We have storage on a remote machine with `ssh` access, that domain is in `TEXCOLLAB_REMOTE_DOMAIN`. On the remote machine exists a place where I put my "in-progress" publications,
something like `/$SOME_PATH/shared/latex/barrymoo/$PROJECT_NAME`, which I set as `TEXCOLLAB_REMOTE_DIR` (obviously
all but the `$PROJECT_NAME` should already exist!). The project name should be unique and will be stored on the
remote machine as `$PROJECT_NAME.git` (a standard style for git remote repos). Next, you should set your advisors
and your user name for `TEXCOLLAB_ADVISOR/TEXCOLLAB_STUDENT`, respectively. To finish the environment make sure
the `remote-texcollab-helper.sh` is available on the `TEXCOLLAB_REMOTE_DOMAIN` for all collaborators. Now you're ready
to initialize the directory! Place your `*.tex` file, `*.bib` files (if necessary), and figures to the `figures`
directory (Always use `supporting-information.tex` for supporting information). Run `texcollab init`, if you have
figures run `texcollab figures push` (additionally), and let the git magic ensue :) Note, that `texcollab compile`
exists and you should probably make sure it compiles properly before sending it to your advisor (they hate
when it doesn't compile right!). 

# How does my advisor use this model?

Also easy! Send him/her the `.texcollab` file. They navigate to wherever they want the local copy and run
`texcollab clone $TEXCOLLAB_REMOTE_DOMAIN:$TEXCOLLAB_REMOTE_DIR` (note I don't add `.git` ending!), if you have
figures run `texcollab figures pull`, they need to run `texcollab branch $TEXCOLLAB_STUDENT` to make the
student branch visible (git doesn't do this automatically), and `texcollab compile`. Voila!

# What do I do now, how do we share commits?

Again, easy :P I hope you see the pattern now. Both the student and advisor can make changes willy-nilly! Commit,
push, pull, figures push/pull, etc. When the advisor, or student, are ready to "merge" changes
run `texcollab compare main.tex` (main.tex for example), this will open up the `TEXCOLLAB_MERGE_TOOL`
(we like meld) and then one can pick and choose the changes (or don't!). Finally, commit/push and the
other collaborator is ready to pull.

# Cool, how do I add collaborators?

I won't say it this time. Pass the collaborator the `.texcollab`, have them change the `TEXCOLLAB_STUDENT`
variable, clone the repository as the advisor does, and `texcollab checkout $USER` (the $USER should be equal
to `TEXCOLLAB_STUDENT` point). Now, the advisor can pull and `texcollab branch $new_student_branch` to `meld`
with both students changes. Note this is the only time one uses `checkout`, always use `branch` to change or
list branches!

# Anything else?

This is work in progess and I haven't done much testing as of yet. Please send me issues, or suggestions, here
on github. I am very interested in making a nice collaboration tool for everyone. Feel free to fork, and submit
pull requests :). 

# Stuff I want to add

* Some fancy `texcollab log` output, to make viewing changes/previous commits easy.
* Extension of `compare`, or new command (maybe <previous>), to deal with comparisons of previous committed files
  on current/different branches
* Maybe a <view> command to look at previous committed files on current/different branches
