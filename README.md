# nbcli-config
Repository for nbcli (nothing but CLI) meta-instrument project at https://magfoto.dev/nbcli, which is currently being developed for use with [sigv](https://magfoto.itch.io/sigv), a macOS tool.

## Installation
The project sends messages using OSC (Open Sound Control), to [sigv](https://magfoto.itch.io/sigv) and other instruments. 

### Install
\$ git clone https://github.com/magfoto/nbcli-config.git ~/sigv

### Install Dependencies
nbcli uses sendosc (installed via Homebrew on macOS): https://github.com/yoggy/sendosc

\$ brew install yoggy/tap/sendosc

### Add nbcli to your Terminal session
\$ source ~/sigv/nbcli/.sigvsh

#### Test installation by opening sigv 
(sigv needs to be installed of course, preferably in your main /Applications directory)

1. \$ sigv (this should open sigv, which is only a very small translucent window with a "quit" button at the bottom right of your screen)
2. \$ new wrld 0 0 wrld (this should open a window)
3. \$ qs (quits the sigv application)


## Structure
nbcli currently has a small list of functions and a full list of commands to access the sigv instrument. It also contains a directory of o-sigv files to be read as concats (```cat``` command) via terminal, used as reference when using Orca in live coding performance. Web version is here: https://magfoto.dev/o-sigv/table.html.


### sigv Commands
sigv is built with Max, as such nbcli consists of a directory (/max) in which these commands exist.

#### First Steps: Initialize the 3D world
1. Open a terminal window
2. \$ source ~/sigv/nbcli/.sigvsh
3. \$ new wrld 0 0 wrld

#### Add a primitive
4. \$ new geo 0 0 geo
5. \$ geo reset (this should display a plane in wireframe)

#### Rotate the primitive
6. \$ geo anim turn 0 1 0

#### Change drawing mode
7. \$ geo mesh draw_mode quad_grid
8. \$ geo 


## Ongoing development
This project is currently in development.