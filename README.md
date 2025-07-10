# nbcli
Repository for nbcli (nothing but CLI) meta-instrument project at https://nbcli.space which is currently being developed for use with [sigv](https://magfoto.itch.io/sigv), a macOS tool.

## Installation
[sigv by magfoto](https://magfoto.itch.io/sigv)    
   
1. Download the above sigv application which should be be a blue "Download" button at the bottom of the page (which will be a zip of an .app file)   
2. Extract the zip to the /Applications folder of your macOS.   
3. Double-click the sigv.app, and it should show a privacy notice window (this indicates you need to give it permission to install)   
4. To give permission to install, open the "Privacy and Security" section your "Settings" app on your mac (CMD + Spacebar, type Privacy & Settings, hit enter)   
5. Keeping this window open, double-click sigv.app again, notice will come up, but after closing, an "Open Anyway" button will show in your Privacy and Settings window giving you access to permit sigv to launch.   
   
   
### Install nbcli   
   
Now that you have the sigv desktop application installed, we can now turn your attention to your terminal window (CMD + Spacebar, start typing terminal.app, hit enter/return). We will enter the following command that will install nbcli and its dependencies, after which it will add the sigv configuration file to your shell (via ~/.zprofile):   
```
curl -s https://gist.githubusercontent.com/magfoto/5381625aa8309762f72a3a2feafaf453/raw/8a58e111c1f173fcf0100f37d12e4a99947226d3/nbcli-install.sh  | sh
```
   
Run sigv by entering the command in terminal:   
```
sigv
```
   
You are now ready to use nbcli commands in your terminal. Follow the examples below.   
 --- 
   
## A. Hello Monde   
   
```
new wrld 0 0 wrld
wrld border 0
new geo 0 0 geo
geo reset
geo anim turn 0 1 0
geo anim turn 0 .35 0
geo mesh draw_mode line_loop
geo gs1 shape sphere
geo mesh poly_mode 0 0
geo mesh draw_mode points
geo mesh point_size 7.5
geo anim turn 0 0 0
zap geo
zap wrld
qs
```
   
## B. Pic me!   
   
```
new wrld 0 0 wrld
wrld border 0
new geo 0 0 geo
geo reset
fpic read "/Users/username/pic.jpg"
fpic 1 read "/Users/username/photos/another-pic.jpg"
fpic 2 read "https://mygallery.github.io/assets/remote-video.mp4"
geo mesh poly_mode 0 0
geo mesh draw_mode quad_grid
geo material diffuse_texture tex0
geo material diffuse_texture tex1
geo material diffuse_texture tex2
qs
```
   
## C. Motions   
   
```
new wrld 0 0 wrld
wrld size 400 400
wrld dim 400 400 
wrld border 0
new geo 0 0 geo
geo reset
geo anim moveto -1.5 0 0 1
geo anim moveto -1.5 1.5 0 1
geo anim moveto 0 1.5 0 1
geo anim moveto 0 0 0 1
qs
```