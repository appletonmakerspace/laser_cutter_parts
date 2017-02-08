DSPscreensz=[150,100,4];
DSPscreenr=2;

currentscreen=[73,40,3];
tempscreen=[71.14+1,24.12+1,3];
tempscreen2=[80+1,35.9+1,6.2];

DSPbacksz=[80,70,25];
DSPbezelT=4;
angle=20;
cornerradius=4;
innerradius=3;
wallt=5;
topt=5;
facesz=[currentscreen[0]+wallt*2+5*3+100,170];

h=15;//height at theoretical front corner. (doesn't exist because of radius)

module roundedbox(sz, radius)
{
    hull(){
        for(x=[radius/2,sz[0]-radius/2])
        for(y=[radius/2,sz[1]-radius/2])
        for(z=[radius/2,sz[2]-radius/2])
        translate([x,y,z])
        sphere(r=radius);
    }    
    
    
}
//h=100;
//rotate([angle,0,0]) roundedbox([DSPscreensz[0]+DSPbezelT*2,DSPscreensz[1]+DSPbezelT*2,h], radius=cornerradius.);

module splate(xsz,ysz, cornerradius){
    hull(){
        for(x=[cornerradius,xsz-cornerradius])
        for(y=[cornerradius,ysz-cornerradius])
        translate([x,y,cornerradius])
        sphere(r=cornerradius);
    }
}
module cplate(xsz,ysz,t, cornerradius){
    hull(){
        for(x=[cornerradius,xsz-cornerradius])
        for(y=[cornerradius,ysz-cornerradius])
        translate([x,y,0])
        cylinder(r=cornerradius, h=t);
    }
}




module pillar(facesz, h, cornerradius, angle){
//height at theoretical front corner. (doesn't exist because of radius)
        hull(){
            
        translate([0,cornerradius,h-cornerradius])
        rotate([angle,0,0])
        translate([0,-cornerradius,-cornerradius])
        splate(facesz[0], facesz[1], cornerradius);
        
        cplate(facesz[0], facesz[1]*cos(angle),cornerradius,cornerradius);
        }
    }        

module bezel(){
    offset1=(facesz[0]-DSPscreensz[0])/2;
    difference(){

        union(){
        translate([0,cornerradius,topt*cos(angle)-cornerradius])
        rotate([-angle,0,0])
        translate([0,-cornerradius,-h+cornerradius])
        difference()  {
        pillar(facesz, h, cornerradius, angle);

        translate([wallt,wallt,-topt*cos(angle)])
        pillar([for(v=facesz)v-2*wallt], h, innerradius, angle);
        }
        
        translate([offset1-5,wallt+6-5,.5-topt])
        cplate(DSPscreensz[0]+10,DSPscreensz[1]+10,topt+1,DSPscreenr);
        }
        
        translate([offset1,wallt+6,0])
        cplate(DSPscreensz[0],DSPscreensz[1],topt*2,DSPscreenr);

        translate([offset1,wallt+6,-topt])
        cplate(DSPscreensz[0],DSPscreensz[1],topt*2,30);

        translate([facesz[0]/2,wallt+6+DSPscreensz[1]/2,0])
        for(i = [-1,1])
        for(j = [-1,1])
        translate([i*141/2,j*91/2,-50])
        cylinder(r=2, h=100);
        
        offset2=(facesz[0]-currentscreen[0]-tempscreen[0])/3;
        //offset2=cornerradius+2+4;
        translate([offset2,wallt+6+DSPscreensz[1]+6,-topt]){
            cplate(currentscreen[0],currentscreen[1],topt*2,1);
            translate([-4,0,-2.4])
            cplate(currentscreen[0]+8,currentscreen[1],topt*2,1);
        }
        translate([offset2+currentscreen[0]+offset2,(wallt+6+DSPscreensz[1])+(facesz[1]-cornerradius-(wallt+6+DSPscreensz[1]))/2-tempscreen[1]/2,-.5]){
            cplate(tempscreen[0],tempscreen[1],topt+1,1);
            translate([(tempscreen[0]-tempscreen2[0])/2,(tempscreen[1]-tempscreen2[1])/2,.5-3.2+4.3-2.4])
            cplate(tempscreen2[0],tempscreen2[1],3.2,13);
        translate([tempscreen[0]/2,tempscreen[1]/2,0])
        for(i = [-1,1])
        for(j = [-1,1])
        translate([i*75/2,j*31/2,-10-.7+5])
        cylinder(r=1.1, h=10);

    
            }
        

    }
}

module base(){

union(){
cplate(facesz[0], (facesz[1])*cos(angle),4,cornerradius);
translate([wallt,wallt,3])
cplate(facesz[0]-2*wallt, (facesz[1]-2*wallt)*cos(angle),4,cornerradius);
}
}
bezel();
//base();
