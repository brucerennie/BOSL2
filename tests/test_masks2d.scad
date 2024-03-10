include<../std.scad>

module test_mask2d_chamfer() {
    assert_approx(mask2d_chamfer(x=10),[[10,-0.01],[-0.01,-0.01],[-0.01,10],[0,10],[10,0]]);
    assert_approx(mask2d_chamfer(y=10),[[10,-0.01],[-0.01,-0.01],[-0.01,10],[0,10],[10,0]]);
    assert_approx(mask2d_chamfer(edge=10),[[7.07106781187,-0.01],[-0.01,-0.01],[-0.01,7.07106781187],[0,7.07106781187],[7.07106781187,0]]);
    assert_approx(mask2d_chamfer(x=10,angle=30),[[10,-0.01],[-0.01,-0.01],[-0.01,17.3205080757],[0,17.3205080757],[10,0]]);
    assert_approx(mask2d_chamfer(y=10,angle=30),[[5.7735026919,-0.01],[-0.01,-0.01],[-0.01,10],[0,10],[5.7735026919,0]]);
    assert_approx(mask2d_chamfer(edge=10,angle=30),[[5,-0.01],[-0.01,-0.01],[-0.01,8.66025403784],[0,8.66025403784],[5,0]]);
    assert_approx(mask2d_chamfer(x=10,angle=30,inset=1),[[11,-0.01],[-0.01,-0.01],[-0.01,18.3205080757],[1,18.3205080757],[11,1]]);
    assert_approx(mask2d_chamfer(y=10,angle=30,inset=1),[[6.7735026919,-0.01],[-0.01,-0.01],[-0.01,11],[1,11],[6.7735026919,1]]);
    assert_approx(mask2d_chamfer(edge=10,angle=30,inset=1),[[6,-0.01],[-0.01,-0.01],[-0.01,9.66025403784],[1,9.66025403784],[6,1]]);
    assert_approx(mask2d_chamfer(x=10,angle=30,inset=1,excess=1),[[11,-1],[-1,-1],[-1,18.3205080757],[1,18.3205080757],[11,1]]);
    assert_approx(mask2d_chamfer(y=10,angle=30,inset=1,excess=1),[[6.7735026919,-1],[-1,-1],[-1,11],[1,11],[6.7735026919,1]]);
    assert_approx(mask2d_chamfer(edge=10,angle=30,inset=1,excess=1),[[6,-1],[-1,-1],[-1,9.66025403784],[1,9.66025403784],[6,1]]);
}
test_mask2d_chamfer();


module test_mask2d_cove() {
    $fn = 24;
    assert_approx(mask2d_cove(r=10),[[10,-0.01],[-0.01,-0.01],[-0.01,10],[1.7763568394e-15,10],[3.09016994375,9.51056516295],[5.87785252292,8.09016994375],[8.09016994375,5.87785252292],[9.51056516295,3.09016994375],[10,1.7763568394e-15]]);
    assert_approx(mask2d_cove(d=20),[[10,-0.01],[-0.01,-0.01],[-0.01,10],[1.7763568394e-15,10],[3.09016994375,9.51056516295],[5.87785252292,8.09016994375],[8.09016994375,5.87785252292],[9.51056516295,3.09016994375],[10,1.7763568394e-15]]);
    assert_approx(mask2d_cove(r=10,inset=1),[[11,-0.01],[-0.01,-0.01],[-0.01,11],[1,11],[4.09016994375,10.510565163],[6.87785252292,9.09016994375],[9.09016994375,6.87785252292],[10.510565163,4.09016994375],[11,1]]);
    assert_approx(mask2d_cove(d=20,inset=1),[[11,-0.01],[-0.01,-0.01],[-0.01,11],[1,11],[4.09016994375,10.510565163],[6.87785252292,9.09016994375],[9.09016994375,6.87785252292],[10.510565163,4.09016994375],[11,1]]);
    assert_approx(mask2d_cove(r=10,inset=1,excess=1),[[11,-1],[-1,-1],[-1,11],[1,11],[4.09016994375,10.510565163],[6.87785252292,9.09016994375],[9.09016994375,6.87785252292],[10.510565163,4.09016994375],[11,1]]);
    assert_approx(mask2d_cove(d=20,inset=1,excess=1),[[11,-1],[-1,-1],[-1,11],[1,11],[4.09016994375,10.510565163],[6.87785252292,9.09016994375],[9.09016994375,6.87785252292],[10.510565163,4.09016994375],[11,1]]);
}
test_mask2d_cove();


module test_mask2d_roundover() {
    $fn = 24;
    assert_approx(mask2d_roundover(r=10),[[10,-0.01],[-0.01,-0.01],[-0.01,10],[-1.7763568394e-15,10],[0.489434837048,6.90983005625],[1.90983005625,4.12214747708],[4.12214747708,1.90983005625],[6.90983005625,0.489434837048],[10,-1.7763568394e-15]]);
    assert_approx(mask2d_roundover(d=20),[[10,-0.01],[-0.01,-0.01],[-0.01,10],[-1.7763568394e-15,10],[0.489434837048,6.90983005625],[1.90983005625,4.12214747708],[4.12214747708,1.90983005625],[6.90983005625,0.489434837048],[10,-1.7763568394e-15]]);
    assert_approx(mask2d_roundover(r=10,inset=1),[[11,-0.01],[-0.01,-0.01],[-0.01,11],[1,11],[1.48943483705,7.90983005625],[2.90983005625,5.12214747708],[5.12214747708,2.90983005625],[7.90983005625,1.48943483705],[11,1]]);
    assert_approx(mask2d_roundover(d=20,inset=1),[[11,-0.01],[-0.01,-0.01],[-0.01,11],[1,11],[1.48943483705,7.90983005625],[2.90983005625,5.12214747708],[5.12214747708,2.90983005625],[7.90983005625,1.48943483705],[11,1]]);
    assert_approx(mask2d_roundover(r=10,inset=1,excess=1),[[11,-1],[-1,-1],[-1,11],[1,11],[1.48943483705,7.90983005625],[2.90983005625,5.12214747708],[5.12214747708,2.90983005625],[7.90983005625,1.48943483705],[11,1]]);
    assert_approx(mask2d_roundover(d=20,inset=1,excess=1),[[11,-1],[-1,-1],[-1,11],[1,11],[1.48943483705,7.90983005625],[2.90983005625,5.12214747708],[5.12214747708,2.90983005625],[7.90983005625,1.48943483705],[11,1]]);
}
test_mask2d_roundover();


module test_mask2d_dovetail() {
    assert_approx(mask2d_dovetail(width=10,angle=30),[[0,-0.01],[-0.01,-0.01],[-0.01,17.3205080757],[0,17.3205080757],[10,17.3205080757],[0,0]]);
    assert_approx(mask2d_dovetail(height=10,angle=30),[[0,-0.01],[-0.01,-0.01],[-0.01,10],[0,10],[5.7735026919,10],[0,0]]);
    assert_approx(mask2d_dovetail(edge=10,angle=30),[[0,-0.01],[-0.01,-0.01],[-0.01,8.66025403784],[0,8.66025403784],[5,8.66025403784],[0,0]]);
    assert_approx(mask2d_dovetail(width=10,angle=30),[[0,-0.01],[-0.01,-0.01],[-0.01,17.3205080757],[0,17.3205080757],[10,17.3205080757],[0,0]]);
    assert_approx(mask2d_dovetail(height=10,angle=30),[[0,-0.01],[-0.01,-0.01],[-0.01,10],[0,10],[5.7735026919,10],[0,0]]);
    assert_approx(mask2d_dovetail(edge=10,angle=30),[[0,-0.01],[-0.01,-0.01],[-0.01,8.66025403784],[0,8.66025403784],[5,8.66025403784],[0,0]]);
    assert_approx(mask2d_dovetail(width=10,angle=30,inset=1),[[1,-0.01],[-0.01,-0.01],[-0.01,18.3205080757],[1,18.3205080757],[11,18.3205080757],[1,1]]);
    assert_approx(mask2d_dovetail(height=10,angle=30,inset=1),[[1,-0.01],[-0.01,-0.01],[-0.01,11],[1,11],[6.7735026919,11],[1,1]]);
    assert_approx(mask2d_dovetail(edge=10,angle=30,inset=1),[[1,-0.01],[-0.01,-0.01],[-0.01,9.66025403784],[1,9.66025403784],[6,9.66025403784],[1,1]]);
    assert_approx(mask2d_dovetail(width=10,angle=30,inset=1,excess=1),[[1,-1],[-1,-1],[-1,18.3205080757],[1,18.3205080757],[11,18.3205080757],[1,1]]);
    assert_approx(mask2d_dovetail(height=10,angle=30,inset=1,excess=1),[[1,-1],[-1,-1],[-1,11],[1,11],[6.7735026919,11],[1,1]]);
    assert_approx(mask2d_dovetail(edge=10,angle=30,inset=1,excess=1),[[1,-1],[-1,-1],[-1,9.66025403784],[1,9.66025403784],[6,9.66025403784],[1,1]]);
}
test_mask2d_dovetail();


module test_mask2d_rabbet() {
    assert_approx(mask2d_rabbet(10), [[10,-0.01],[-0.01,-0.01],[-0.01,10],[0,10],[10,10],[10,0]]);
    assert_approx(mask2d_rabbet(size=10), [[10,-0.01],[-0.01,-0.01],[-0.01,10],[0,10],[10,10],[10,0]]);
    assert_approx(mask2d_rabbet(size=[10,15]), [[10,-0.01],[-0.01,-0.01],[-0.01,15],[0,15],[10,15],[10,0]]);
    assert_approx(mask2d_rabbet(size=[10,15],excess=1), [[10,-1],[-1,-1],[-1,15],[0,15],[10,15],[10,0]]);
}
test_mask2d_rabbet();


module test_mask2d_teardrop() {
    $fn=24;
    assert_approx(mask2d_teardrop(r=10), [[6.03197753333,-0.01],[-0.01,-0.01],[-0.01,10],[-1.7763568394e-15,10],[0.489434837048,6.90983005625],[1.90983005625,4.12214747708],[4.12214747708,1.90983005625],[6.03197753333,-4.4408920985e-16]]);
    assert_approx(mask2d_teardrop(d=20), [[6.03197753333,-0.01],[-0.01,-0.01],[-0.01,10],[-1.7763568394e-15,10],[0.489434837048,6.90983005625],[1.90983005625,4.12214747708],[4.12214747708,1.90983005625],[6.03197753333,-4.4408920985e-16]]);
    assert_approx(mask2d_teardrop(r=10,angle=30), [[4.28975301178,-0.01],[-0.01,-0.01],[-0.01,10],[-1.7763568394e-15,10],[0.489434837048,6.90983005625],[1.90983005625,4.12214747708],[4.28975301178,0]]);
    assert_approx(mask2d_teardrop(r=10,angle=30,excess=1), [[4.28975301178,-1],[-1,-1],[-1,10],[-1.7763568394e-15,10],[0.489434837048,6.90983005625],[1.90983005625,4.12214747708],[4.28975301178,0]]);
}
test_mask2d_teardrop();


module test_mask2d_ogee() {
    $fn=24;
    assert_approx(
        mask2d_ogee([
            "xstep",1,  "ystep",1,  // Starting shoulder.
            "fillet",5, "round",5,  // S-curve.
            "ystep",1,  "xstep",1   // Ending shoulder.
        ]),
        [[12,-0.01],[-0.01,-0.01],[-0.01,12],[1,12],[1,11],[1.32701564615,10.9892946162],[1.6526309611,10.9572243069],[1.97545161008,10.903926402],[2.29409522551,10.8296291314],[2.60719732652,10.7346506475],[2.91341716183,10.6193976626],[3.2114434511,10.4843637077],[3.5,10.3301270189],[3.7778511651,10.1573480615],[4.04380714504,9.96676670146],[4.2967290755,9.75919903739],[4.53553390593,9.53553390593],[4.75919903739,9.2967290755],[4.96676670146,9.04380714504],[5.15734806151,8.7778511651],[5.33012701892,8.5],[5.48436370766,8.2114434511],[5.61939766256,7.91341716183],[5.73465064748,7.60719732652],[5.82962913145,7.29409522551],[5.90392640202,6.97545161008],[5.95722430687,6.6526309611],[5.98929461619,6.32701564615],[6,6],[6.01070538381,5.67298435385],[6.04277569313,5.3473690389],[6.09607359798,5.02454838992],[6.17037086855,4.70590477449],[6.26534935252,4.39280267348],[6.38060233744,4.08658283817],[6.51563629234,3.7885565489],[6.66987298108,3.5],[6.84265193849,3.2221488349],[7.03323329854,2.95619285496],[7.24080096261,2.7032709245],[7.46446609407,2.46446609407],[7.7032709245,2.24080096261],[7.95619285496,2.03323329854],[8.2221488349,1.84265193849],[8.5,1.66987298108],[8.7885565489,1.51563629234],[9.08658283817,1.38060233744],[9.39280267348,1.26534935252],[9.70590477449,1.17037086855],[10.0245483899,1.09607359798],[10.3473690389,1.04277569313],[10.6729843538,1.01070538381],[11,1],[11,0],[12,0]]
    );
}
test_mask2d_ogee();

