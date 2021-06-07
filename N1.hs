{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module N1 (program1) where

import Data.Array.Accelerate
import Prelude ()


class (Slice slix, Shape sl, Shape sh) => SliceExt slix sl sh where
    indexFull :: Exp slix -> Exp sl -> Exp sh
    indexSlice :: Exp slix -> Exp sh -> Exp sl

instance SliceExt Z Z Z where
    indexFull Z_ Z_ = Z_
    indexSlice Z_ Z_ = Z_

instance SliceExt slix sl sh => SliceExt (slix :. All) (sl :. Int) (sh :. Int) where
    indexFull (slix ::. _) (sl ::. n) = indexFull slix sl ::. n
    indexSlice (slix ::. _) (sh ::. n) = indexSlice slix sh ::. n

instance SliceExt slix sl sh => SliceExt (slix :. Int) sl (sh :. Int) where
    indexFull (slix ::. n) sl = indexFull slix sl ::. n
    indexSlice (slix ::. _) (sh ::. _) = indexSlice slix sh

{-# NOINLINE program1 #-}
program1 :: Acc (Array DIM2 Float)
program1 =
    let a5 = use (fromList (Z :. 5) [-0.649014,1.1811659,-0.758453,-1.109613,-0.845551] :: Array (Z :. Int) Float)
        a6 = use (fromList (Z :. 5 :. 2) [0.345561,0.396767,0.538817,0.419195,0.68522,0.204452,0.878117,2.7388e-2,0.670468,0.417305] :: Array (Z :. Int :. Int) Float)
        a8 = use (fromList (Z :. 1000 :. 2) [1.270848,6.6009e-2,0.45129,-0.32221,0.788409,0.928736,-0.49079,1.7972009,0.590697,-0.635786,0.603347,-0.535248,-0.15508,0.612122,-1.044343,-0.345632,-1.171405,-0.685587,0.926216,-1.481675,-0.558058,-2.8453e-2,-1.476292,0.2589,-2.018691,0.19974,0.425864,-1.270043,-0.485219,0.594308,-0.276465,-1.857583,4.0731e-2,0.28297,6.3561e-2,0.43343,0.42286,1.299528,-1.049793,-1.786412,0.816043,-0.328209,-1.214566,1.111833,-0.507497,0.89873,0.377216,1.452392,0.446945,0.645825,-0.623677,-0.595236,1.6113241,-0.348998,0.164167,-1.636577,0.581366,-0.128906,0.432859,-0.245109,-1.08543,1.680802,0.176412,-2.07144,0.211089,-0.582848,1.8169e-2,1.494778,-0.424797,1.686243,0.36549,-1.097061,1.930213,0.622936,0.657284,-1.463383,0.853935,0.580489,-0.918601,0.794865,0.517535,0.494614,0.66393,-0.710172,-1.306838,-0.741589,-1.467659,-0.391675,0.841659,8.2784e-2,0.314671,0.789805,-0.801224,-0.325654,0.284676,1.309618,0.160373,-2.118188,0.707081,-1.043414,1.068207,-0.317234,1.479677,0.699088,0.159099,-0.945481,-0.793007,-2.049239,-2.358835,-1.659269,-0.958124,0.22573,0.217665,-0.823239,-1.012768,1.215258,0.156275,-0.400257,-0.441779,0.448102,-1.6645911,0.21489,0.549563,1.392338,-0.619228,-1.2601e-2,0.773612,1.629212,-1.409975,-1.747283,-0.472246,-6.0088e-2,0.438879,0.201222,-0.583298,0.764797,0.14077,-0.372937,0.105467,1.270624,0.49913,-0.397025,-1.789968,-0.266894,0.178431,-0.434192,0.464513,-1.121445,-0.359075,0.532267,-1.643508,0.466899,0.112107,1.496544,-0.586502,-1.7189319,0.74104,1.087696,0.75667,1.629694,-1.374993,-1.052011,0.477518,1.222177,2.370732,0.114586,0.279069,0.75208,-0.260257,-2.5993e-2,9.6724e-2,0.144143,1.856209,1.100335,-0.364107,0.471993,-0.839107,-0.523633,-1.388766,4.248e-3,-1.404783,2.629018,0.819529,-1.443411,-0.499729,-0.517959,-1.802747,0.988435,-0.360753,1.132659,0.409018,0.819121,0.319661,2.415006,-0.114032,0.118016,0.999691,-0.357659,-5.5026e-2,0.241456,-2.73518,0.193514,-0.145396,1.454576,-0.396689,1.728903,0.251893,-0.618553,0.976329,0.130991,-0.364357,-9.3312e-2,0.489806,1.401431,-0.274223,0.675816,0.190581,0.670363,0.208357,0.327875,-0.823197,0.331906,0.343914,0.379748,1.088939,0.994859,0.20861,-0.399188,0.506011,-0.127763,-0.254921,-7.8043e-2,-0.314649,-0.308418,0.401268,-0.129421,1.327683,0.670787,-0.691715,-4.9218e-2,-0.326731,0.303248,2.0565,1.707191,0.510742,-0.187689,-0.589429,1.143276,0.130368,0.586463,0.103399,0.264541,5.4799e-2,0.221252,9.1006e-2,-0.150115,-0.561297,-1.799185,-0.470727,-0.902588,0.547841,-0.735208,1.475863,0.505823,0.692664,0.134881,-1.06878,-0.167592,-0.462884,-1.263564,0.420394,-0.324321,1.341096,1.213663,-0.502785,-1.116363,-0.922072,-1.042e-3,0.15349,-0.90397,-0.938332,0.433891,-0.153153,0.402438,-0.652552,-1.957691,6.7693e-2,-4.732e-2,-0.696919,0.457548,7.9304e-2,0.479593,-2.360392,0.444008,-0.324989,9.7206e-2,1.114805,-1.157063,-0.475713,0.522585,0.887144,1.6548e-2,0.902542,1.154784,0.872534,-0.469163,0.596529,0.836092,0.304493,1.155324,-1.571514,1.636478,0.554831,-0.585432,-0.510444,0.492702,-0.650826,0.926873,-0.188116,0.320829,1.420298,-1.189962,-0.928444,1.309552,0.115346,2.828126,0.274099,0.115688,-1.070368,-0.709702,-1.513138,-1.136958,1.272192,-1.144058,-0.526164,1.5781779,0.578636,0.578573,-1.422806,-0.190392,0.186023,1.483995,-0.679469,-0.530061,-0.859494,1.306356,-8.633e-2,-2.150373,2.5232e-2,-1.135619,0.714953,-0.616843,-0.955457,0.13556,0.637969,-0.366977,1.06141,5.6378e-2,8.5413e-2,1.836021,0.675363,-1.545835,0.353632,-9.244e-2,0.638395,-0.86296,-0.886446,-1.223166,-0.185643,-1.720509,0.151805,0.816508,0.577798,1.063851,-0.803239,0.798627,-0.315092,1.186064,8.4939e-2,-1.424976,-1.454111,-1.8093159,-1.462947,-0.138068,-1.005592,-2.733304,1.692405,-0.283386,1.122142,-0.306948,-0.168531,-8.1308e-2,-3.7718e-2,2.091389,-0.41063,2.95757,-1.687389,0.290257,-1.469352,0.449062,-1.695895,6.0461e-2,-1.147612,1.9939361,0.920892,1.6227009,-0.487547,-1.195582,-1.4194701,0.46822,1.329924,2.304717,0.851429,0.521839,3.201293,-0.330453,-0.896356,-0.99395,-1.871669,1.497869,-1.632447,-0.851817,1.0774,-0.440099,3.327984,0.103796,-0.773079,0.677374,-0.696817,-7.5351e-2,2.6019e-2,2.005536,-1.129631,0.654237,1.419167,-0.825613,5.3107e-2,-0.855855,1.768118,0.182871,0.431022,-0.228818,0.393997,-0.525875,-2.44696,0.155245,-0.834079,7.8468e-2,1.31271,-0.135124,-1.409995,-0.162703,2.109836,1.4625859,0.914106,1.512145,-0.454165,-1.139403,-0.705497,-0.331098,-1.520792,0.165279,-0.48787,0.586965,-0.903369,0.371008,-1.260143,0.222889,-0.413064,-1.016668,-0.326023,0.283502,-1.1569e-2,3.6267e-2,-1.098303,0.375683,0.170055,1.139668,1.657464,0.338248,-1.8189709,-0.802271,-0.574424,-0.234256,-0.305201,1.639446,-1.897236,1.3185201,0.532359,0.601598,0.467189,0.208181,-5.7599e-2,-3.065186,-0.612494,-1.6162e-2,0.7769,-9.0006e-2,-0.148789,-0.887773,-0.776091,0.629228,-1.31584,0.898735,-0.825132,-0.575501,2.5326e-2,0.562567,-0.172096,-0.648153,-0.153145,1.7124e-2,0.827807,0.698925,-1.006189,-2.244176,0.102301,0.901808,-3.005798,0.659237,0.760341,-0.169916,0.708616,0.628756,-0.763568,1.187671,1.163956,0.43791,0.764358,0.172088,-0.635979,0.263635,0.557991,-0.323506,0.23893,-0.668543,0.54218,-0.734938,0.616388,-0.228798,0.821,-0.155227,-1.308308,0.777575,-1.180115,0.287776,0.449292,-0.536068,-0.920966,-0.686498,-1.09287,-0.488991,-0.918765,-2.031704,0.639006,1.135888,-0.785609,-1.012202,-1.008377,1.52116,0.66327,7.1216e-2,-0.584426,1.01464,-0.226944,0.644054,0.200877,-2.9035e-2,-0.992314,1.983578,-0.939563,-1.609478,-0.219788,-0.27741,-0.880145,0.583931,-0.36393,0.41669,1.286826,-1.4039149,0.444248,1.440858,0.332877,0.515995,-0.232061,0.602345,0.612538,-0.392011,0.710826,-1.8948231,1.358329,-0.911798,-0.149636,-0.40114,-0.577582,2.003854,-0.509643,8.8893e-2,-1.9698e-2,-0.738074,-1.152164,-1.947602,2.6296e-2,-0.825893,-0.717992,-1.940978,0.987546,-1.6631169,2.063314,-2.082036,0.273162,-2.376736,0.379466,-0.99132,9.4217e-2,0.643802,-0.782961,0.148621,-0.920779,1.191122,0.980936,-0.723429,2.334377,-2.551227,0.902509,0.227135,-0.351252,0.527464,0.874846,3.068098,-0.618881,0.757522,1.028627,5.284e-2,0.210857,1.152476,-0.352294,0.51556,0.962176,0.387157,-0.225196,0.249426,-1.916009,0.711205,1.5629029,-0.825379,-0.568134,-0.723674,-1.008999,0.730514,8.521e-2,-0.427966,-0.596362,-0.745602,0.642888,-0.193149,-0.12576,-7.3857e-2,1.122151,-0.252944,-0.395011,0.393903,-0.678536,-0.165741,-0.509151,0.489158,1.226135,-0.152181,0.838969,-6.6415e-2,0.882032,-0.614498,-0.113187,0.752232,0.502254,1.7715139,2.5691e-2,-5.188e-3,1.034393,-1.6025829,0.322434,2.312027,2.5913e-2,-0.50997,1.390458,-1.457564,0.666306,0.22473,2.098755,0.479445,0.650313,-1.7261469,1.6036711,-0.54618,-0.510315,2.098672,1.02184,-0.204025,-1.148959,1.057324,-7.0703e-2,-1.6616449,1.725458,0.981133,-1.8408e-2,1.300162,-0.282012,0.242475,-0.273552,1.8418e-2,-1.537433,2.541337,-0.42599,-1.305117,-0.607644,-1.881951,0.389123,2.7765e-2,1.4656e-2,1.476658,0.2532,0.653493,-0.165081,0.53632,-0.559253,-0.431607,-1.8708279,-0.473182,-1.195105,-0.294704,0.711937,-0.31718,1.345581,0.431573,-0.290225,0.804784,0.349499,-0.674941,1.159802,-3.8383e-2,-0.497727,-0.165461,0.255275,-0.514031,1.049777,-0.297014,0.207544,-1.6294e-2,0.885397,1.70028,-1.692024,0.187102,1.299425,-0.177342,1.266924,-0.642952,0.58898,0.491726,-0.317791,-1.080348,-0.236695,1.037509,-0.505673,1.14925,-1.6583381,-0.658551,-1.174728,0.405981,0.561162,0.763683,-0.251252,0.580274,-0.859688,-0.241693,-0.235381,-0.518473,-0.949763,0.239594,0.558733,0.350337,0.275183,-1.081674,-1.534654,2.4216e-2,1.5714281,-2.038232,-0.205198,-0.179022,-1.0316e-2,-1.244388,-0.704389,-1.0942659,1.129088,1.118448,-0.225268,7.1858e-2,-1.379221,2.9911e-2,-0.397478,1.6917751,0.755117,0.523884,-0.474369,-1.975e-2,3.137981,1.552722,6.2457e-2,0.446259,0.216111,-0.165013,-0.261181,0.128395,0.842844,0.764314,0.220261,1.04058,-1.32476,0.635503,-1.677369,-0.31441,-0.596958,0.417571,-2.304534,-0.775047,-1.620703,0.427633,0.236062,-0.179066,-0.206452,1.218866,-3.9144e-2,7.8823e-2,-0.684109,0.108209,-0.19316,-0.181832,-0.400381,-0.209644,-0.103754,1.330781,-0.541981,0.979114,0.275543,1.4491379,-0.307006,-0.726711,1.278873,-2.764208,-0.568166,2.763304,6.0634e-2,-2.063403,3.064e-2,0.326295,0.731459,1.354879,-0.215322,0.536494,0.574383,-1.5417e-2,5.9954e-2,-0.917658,-0.524292,-1.050423,0.30608,-5.759e-2,-0.177815,1.48189,0.131511,-5.2032e-2,-0.550095,-1.733962,-0.387419,-2.365146,-0.571256,1.0069e-2,1.255723,-0.820761,0.30546,-2.9e-5,-2.243771,-1.863345,-0.195606,1.225722,-0.603548,0.678204,-0.726321,-1.072731,-1.302486,-0.22962,-0.656655,0.381522,-1.4487879,-0.978113,-1.224376,-1.077053,0.623583,-0.457896,-0.561759,0.136208,1.021503,1.936089,1.5613561,1.359023,-1.864756,-1.717061,-6.1872e-2,-0.705292,1.107436,-4.4768e-2,0.118538,0.87822,-7.9947e-2,0.590146,-0.554747,-0.615667,-0.68904,0.116539,-0.855605,0.796908,-2.464211,-0.474592,0.563042,-0.552889,-0.294927,0.124951,0.109075,-1.119832,0.472949,1.7786369,0.800018,-0.658022,0.107852,-0.517307,0.119842,1.930902,-0.532678,0.922536,-1.036749,0.27965,-0.523115,0.546274,0.705333,0.46846,-0.100024,-1.067891,-2.588719,-0.448819,-1.440259,0.934778,0.375977,-0.251271,0.496861,9.2671e-2,-1.964326,-0.401108,-1.093911,-0.678303,-1.970043,0.30721,4.692e-2,0.215869,-0.237293,1.666002,-0.222967,-1.370886,0.856108,0.721929,0.712895,0.644424,-1.29445,-0.82793,-0.564768,-0.228959,0.855717,-1.301764,-7.3907e-2,-2.197588,0.864011,0.645328,-1.193955,-3.4896e-2,-0.712788,2.619028,2.79465,0.629131,1.825779,-0.151243,1.098892,-0.350638,-1.181074,1.6136861,0.412021,-1.347839,1.385443,0.700463,0.322197,0.174338,-0.73382,0.22769,1.197335,-1.436389,-1.569608,1.14647,0.454343,0.142179,-0.800425,-1.156936,0.907952,-0.318833,-1.3671579,0.556305,-0.706028,1.149258,1.3797,-1.7873e-2,0.268011,3.3642e-2,0.388377,0.689099,-0.878603,1.070225,0.16491,-1.385081,-0.990824,0.378418,-1.299425,-0.983455,-1.006416,1.5848429,0.483581,0.959621,-0.545966,0.265402,0.337074,0.375951,-1.049269,1.073903,1.400704,7.8071e-2,-1.111087,0.929832,-1.4069281,-0.490442,0.796461,0.320721,1.824993,0.125838,1.283284,0.940283,-0.912691,-0.537827,0.273043,-0.188873,-2.040028,0.543943,-0.989055,-1.3856909,1.05535,-1.763258,-0.91417,-2.565918,1.4272981,9.8617e-2,-0.67137,0.860693,3.3095e-2,-0.177832,0.471082,-0.714685,-1.025397,-0.631256,-0.370778,0.503666,0.334579,-1.210928,2.202782,0.739613,0.51102,0.60955,-1.249831,-6.9658e-2,-0.194669,0.408094,-0.131232,0.345063,0.567662,0.682841,0.23988,-2.55074,0.455502,1.103101,1.460408,-1.147892,-1.129392,-0.42935,-0.575551,1.140118,0.279726,0.777319,-6.7074e-2,-1.127798,-2.228271,-0.578479,-1.641291,0.776947,0.372653,0.654082,-1.7981e-2,-0.764111,-0.630582,-0.123164,-0.763382,-1.43145,1.092311,0.974652,-0.548736,0.660927,-0.274718,1.5416651,0.450625,0.36228,-0.810577,0.156968,0.47419,-0.593522,1.777381,1.9001,-0.729995,0.567137,1.77529,-1.285679,1.749748,-1.2583361,0.989469,0.27894,-0.465374,-0.488536,0.665811,0.418114,1.462554,0.335251,2.40299,0.393666,-1.466521,-0.126054,-0.763374,2.121088,-0.416574,2.264181,8.2321e-2,-0.520006,-1.180747,-0.633615,-2.151889,0.402166,-0.195042,2.230828,2.399944,-0.692402,-0.162229,-5.7558e-2,0.174049,0.444863,-4.2691e-2,-0.19824,-0.367308,1.4657841,-1.7867739,1.093514,-0.856303,1.1065919,-0.290524,1.46904,-0.865654,-1.404295,0.847919,9.7521e-2,-0.333159,-0.993646,-1.143566,0.669345,1.569589,0.447966,-4.865e-2,2.059576,-1.2816e-2,-0.286836,-0.521384,2.739217,-0.477739,-4.075e-3,-0.164889,1.203063,-0.317745,-0.406169,0.633019,-0.497037,-0.728185,1.249597,0.92506,0.197087,-0.651183,0.539552,0.602599,-0.562677,-1.017254,2.45415,-0.112744,1.013038,-1.171895,0.553411,-0.142873,-0.187075,-1.131094,-0.841685,0.412923,0.270514,1.111905,-2.417977,0.984978,3.924e-3,-0.924147,-0.438564,-0.810727,1.351216,0.66382,1.175967,-0.407248,0.781496,0.16296,1.138742,-4.2322e-2,0.442418,0.646699,-0.517053,6.4634e-2,-0.307538,0.347724,1.005793,-0.208019,-0.597408,1.6408651,0.227081,-0.377023,0.428138,-0.132049,-0.886515,-0.180674,-0.24024,-0.936197,1.330593,0.440625,0.276915,0.760755,0.13696,0.545831,1.667585,1.737473,-1.254637,-1.294533,-0.964987,0.469358,-1.701826,-1.7836909,7.115e-3,-2.014121,-0.376815,0.11562,-0.140702,0.140048,0.131192,-0.40737,0.694377,0.52641,0.340887,7.1898e-2,-0.437718,0.415835,1.695116,0.367122,1.598791,-0.207826,0.488457,-0.84155,0.258079,3.4554e-2,-3.050739,5.527e-2,1.042438,-1.433486,0.207367,0.843444,0.623283,0.665856,-1.747095,-0.69142,1.021363,1.361615,0.280825,1.374338,1.401148,1.897727,2.216864,-2.64849,-1.212331,-0.780223,0.98407,-0.838865,0.916415,0.992718,-2.9265e-2,-0.358391,-0.447419,-0.325338,1.405591,0.968044,-0.821511,-1.800446,1.79877,0.759408,-0.32473,1.347627,-0.170958,-0.292201,1.9901149,1.830936,7.1057e-2,1.224062,1.908328,5.2218e-2,-0.318805,0.704243,-9.4564e-2,0.422375,1.586618,1.089697,-0.571568,-3.003727,-0.657189,0.112422,-0.416402,0.62239,1.481456,-0.837786,1.864841,2.002386,2.486594,-1.42535,-1.046819,-2.50074,-0.492231,-1.227192,-0.360028,-0.703424,1.6750281,-4.4736e-2,-0.748775,8.743e-3,0.775834,-1.089363,0.740386,1.525118,0.281176,1.7184219,-0.659537,-0.153709,-2.031314,-0.410772,1.5248699,-0.626564,1.411051,1.258134,1.6079099,-1.425969,1.002946,0.341494,-0.952398,-0.975116,-1.012157,-9.5074e-2,-2.479539,-0.655143,-1.031135,0.795973,0.20681,1.756088,-0.780688,0.390976,-0.93417,5.8291e-2,0.606265,2.046584,-1.207664,-0.560016,-0.512375,-2.24073,-2.918004,-1.3986e-2,-1.009882,-0.576508,0.503709,-0.47409,-0.577089,0.276813,-0.272422,0.613664,-1.254e-2,7.6242e-2,-0.371311,-0.500867,-0.674091,0.877008,1.125489,2.060458,-1.421852,1.120649,1.349898,-0.594968,-1.047639,0.306388,-1.251986,-0.202246,-0.856533,1.020165,-2.0325e-2,1.820871,0.912521,-5.9429e-2,1.132902,-0.674413,0.218215,0.845352,-0.342654,-2.320527,-9.413e-3,-5.606e-2,0.230135,-1.3299379,-0.748974,-1.675668,0.629524,0.722468,-0.790339,0.567432,-0.943679,-2.49556,-1.327819,1.342124,0.989372,-0.649975,1.590874,0.952475,-0.344123,-0.146827,0.412927,-1.5626581,-0.726911,-0.941348,-0.956505,0.477306,0.1041,-0.436985,0.370328,-0.911606,-1.519799,-0.118869,-1.167352,-1.037996,0.921823,-1.4819341,0.897508,-0.662986,-2.423165,0.2268,1.168007,1.9324191,-0.710893,-1.242518,0.4437,0.853337,1.5209479,0.33765,1.0888801,0.995861,-0.214627,0.282503,1.1797e-2,0.576552,0.372862,2.4421e-2,1.07646,1.0723e-2,0.602749,-0.579144,-1.775316,1.291527,0.67796,-1.079676,0.111742,1.109128,-0.427147,-1.256312,0.325869,-1.034902,0.501229,0.202837,0.817382,-1.7169139,-1.548145,0.391017,-0.522497,-1.295524,-0.463986,0.561743,-0.492543,1.828971,1.012713,2.605925,0.410401,-0.350495,0.614012,-0.753268,-0.395643,6.061e-2,0.386044,1.994117,-1.486058,0.910305,1.671051,0.291376,1.378265,-0.869301,1.410504,-0.645844,1.26368,-2.036335,-1.228401,2.687157,0.414916,-0.326202,-0.922502,0.295902,-1.709542,-0.565747,-0.85119,0.488239,0.50928,0.466828,1.551865,0.574965,0.305468,-0.271609,1.6368539,-0.918329,1.7476721,-0.483806,0.140414,0.59412,-0.667448,-1.384475,2.8276e-2,0.661311,1.0740271,-0.25585,1.405784,-4.7369e-2,0.473397,0.193933,-1.876394,-1.079883,1.766644,0.490159,0.582447,-0.550393,0.127244,0.538919,0.162896,-0.66167,-0.309354,-1.97015,2.52586,2.609092,-2.419333,0.619488,-0.46013,0.380081,-0.298418,0.321933,-0.598987,-0.719758,1.488091,1.4254761,0.381774,-0.651108,1.343363,0.168173,0.740556,-0.920689,1.476007,-0.389367,0.35296,0.480556,0.524088,-0.664521,0.731553,0.976035,0.228538,-1.455245,-1.215925,-0.7461,-1.240074,-1.707062,0.516365,-1.6225951,-1.476807,0.676145,1.748286,0.272745,2.226886,-0.930689,1.97394,-0.993759,0.781592,0.97075,0.408482,-3.1097e-2,2.13268,-0.691374,2.425006,0.382084,1.5841069,-1.47333,0.591686,0.209364,-3.5218e-2,-1.168597,-1.016285,-0.864086,-1.137366,1.266779,5.286e-3,-1.93759,1.546082,0.108398,1.271763,4.8317e-2,-0.21634,1.303939,-1.142741,1.311316,2.051579,-0.256556,-1.146276,0.871247,-1.006372,1.732616,-0.489749,-0.583404,1.098543,2.364612,0.179033,1.251404,-0.419145,1.768947,-0.569489,-0.96324,1.9307079,-0.120077,0.812505,0.377595,0.479006,-1.209788,2.543659,1.287611,0.144309,1.5268669,-1.006607,0.211452,-0.316528,0.304727,-0.789559,1.390947,-1.297785,-1.154026,-1.414346,-0.471536,-0.270746,1.7715731,-0.761872,0.463136,4.3234e-2,-0.272297,-0.666099,-0.835331,-1.363822,0.399226,0.1033,-0.140875,0.804887,-0.702804,1.640874,0.544116,0.817136,-0.493178,-0.443245,-0.112355,1.5730929,0.900909,-4.3938e-2,0.336218,1.127386,1.497695,0.5367,0.979811,-0.162961,0.884796,0.328296,8.1479e-2,1.6435239,0.285768,1.028139,-2.110324,0.154457,0.551292,1.6134009,-0.308444,1.74185,-0.624393,-0.950797,0.834728,1.096844,1.8092461,-1.263602,-0.319194,-1.358907,-0.485726,1.031327,0.916304,-0.135149,-0.311103,0.408386,7.3391e-2,0.154629,0.190425,-0.20427,0.710342,-0.798033,0.4156,0.945823,-2.378711,1.121962,-1.7296159,0.158246,0.348852,-0.559672,1.5545471,0.47164,-0.354604,0.811241,-1.303937,0.233458,-2.260891,0.175106,-1.429811,0.396795,0.476348,5.1929e-2,0.460365,0.503732,0.874039,0.147663,-0.160934,-0.339859,0.602541,0.188172,-1.001894,0.174502,0.949861,-0.946103,0.935831,1.018231,-1.045e-3,-0.833251,-0.628753,1.104887,-1.252976,-0.202311,0.290009,-0.742517,0.111719,0.533326,-0.40915,-4.6343e-2,-1.8329e-2,1.212681,0.438186,-0.149976,0.776052,-7.4962e-2,6.7911e-2,0.361587,-0.970316,0.697745,0.50942,1.5208321,-1.790393,-0.146924,1.818151,0.435166,1.160993,-0.290255,0.698371,1.6539841,-1.565575,0.824243,0.926859,-0.667728,-1.164535,-1.264703,1.593097,-1.507024,1.429962,1.427478,-0.95206,-0.462469,1.866076,0.296429,-0.147214,2.8662e-2,0.241104,-0.213853,-0.987176,-1.286907,-1.55095,-2.281599,0.19728,1.048936,-0.573408,-0.885769,-0.185063,0.249932,-0.266165,0.25379,3.45622,1.207095,0.385583,-5.5108e-2,0.386697,-0.885567,2.326527,-1.029277,1.001018,0.67325,0.946184,-0.842216,-1.390835,-0.295268,0.918067,-0.127028,1.23177,-0.120328,0.249015,1.49568,0.609435,-0.88214,-0.117904,-0.712492,7.9739e-2,-0.410533,-1.222103,0.657596,0.400276,1.415698,-0.869836,0.72335,1.185977,0.408701,-1.312178,-0.600989,-7.5575e-2,0.140535,-8.2945e-2,-0.117098,0.194508,1.2710509,0.90454,0.428682,0.270236,1.469233,0.274202,0.372474,-0.807852,0.903695,-1.619173,-1.997339,-1.644271,0.279665,-0.515162,-0.505147,-1.898762,-1.109476,0.85315,4.1763e-2,-1.234451,0.106958,2.061705,2.146114,-0.194492,-0.252709,0.825097,-0.98763,-0.227893,-1.154347,0.470981,-0.234181,0.19478,1.281048,0.488917,-0.196327,-0.697157,0.956338,-1.8828,1.191959,0.282994,1.278309,0.255343,-0.867477,-0.645494,4.4413e-2,2.25746,-1.484112,4.4252e-2,-0.284302,1.739499,1.157655,-0.248293,-0.569306,-2.366017,-1.182801,-0.463968,0.158839,0.965232,-0.847756,2.336049,0.56246,1.4652569,3.114171,-0.205564,3.2179e-2,7.7148e-2,-0.492201,-0.999449,-0.458503,0.792946,0.560063,0.783679,8.6632e-2,-0.920055,0.203042,-0.36707,-0.580465,0.782823,-0.229527,-0.140884,1.029897,0.748527,-1.197893,-1.218873,-0.762116,-1.324856,-1.6074e-2,1.37832,0.852484,0.143564,-1.261026,-1.5983989,0.828816,-1.243628,0.14456,1.2098451,-0.587588,-1.729234,-1.5343649,-0.573974,1.238075,-1.001345,-1.359229,-2.460609,0.936906,-0.555396,-0.324581,-1.422083,-0.295702,-0.205674,-6.0862e-2,-0.224466,-1.2796891,0.388815,-0.447613] :: Array (Z :. Int :. Int) Float)
        a26 =
          fold
            (\x169 x170 -> x169 + x170)
            (0.0 :: Exp Float)
            (generate
               (let shp = (let T2 (T2 (T2 _ x13) x14) x15 = let I3 x16 x17 x18 = indexFull (I3 (let T2 (T2 _ x19) _ = let I2 x20 x21 = shape a8 in T2 (T2 (constant ()) x20) x21 in x19) (constant All) (constant All)) (shape a6) in T2 (T2 (T2 (constant ()) x16) x17) x18
                               T2 (T2 (T2 _ x22) x23) x24 = let I3 x25 x26 x27 = indexFull (I3 (constant All) (let T2 _ x28 = let I1 x29 = shape a5 in T2 (constant ()) x29 in x28) (constant All)) (shape a8) in T2 (T2 (T2 (constant ()) x25) x26) x27
                           in I3 (min x22 x13) (min x23 x14) (min x24 x15))
                    T2 (T2 (T2 _ x137) x138) x139 =
                        let I3 x140 x141 x142 =
                                let T2 (T2 (T2 (T2 _ x113) x114) x115) _ =
                                        let I4 x117 x118 x119 x120 = indexFull (I4 (constant All) (constant All) (let T2 _ x101 = let I2 x102 x103 = shape a8 in T2 (T2 (constant ()) x102) x103 in x101) (constant All)) shp :: Exp DIM4 in T2 (T2 (T2 (T2 (constant ()) x117) x118) x119) x120
                                    T2 (T2 (T2 (T2 _ x121) x122) x123) _ =
                                        let I4 x125 x126 x127 x128 =
                                                (let T2 x79 x80 = let T2 (T2 _ x81) x82 = let I2 x83 x84 = shape a8 in T2 (T2 (constant ()) x83) x84 in T2 x81 x82 in I4 x79 (let T2 _ x85 = let I1 x86 = shape a5 in T2 (constant ()) x86 in x85) x80 x80)
                                        in T2 (T2 (T2 (T2 (constant ()) x125) x126) x127) x128
                                in I3 (min x121 x113) (min x122 x114) (min x123 x115)
                        in T2 (T2 (T2 (constant ()) x140) x141) x142
                    T2 (T2 (T2 _ x143) x144) x145 =
                      let T2 (T2 (T2 _ x146) x147) x148 = let I3 x149 x150 x151 = shp in T2 (T2 (T2 (constant ()) x149) x150) x151
                          T2 (T2 (T2 _ x152) x153) x154 = let I3 x155 x156 x157 = (indexFull (I3 (let T2 (T2 _ x42) _ = let I2 x43 x44 = shape a8 in T2 (T2 (constant ()) x43) x44 in x42) (constant All) (constant All)) (I2 (let I1 x2 = shape a5 in x2) (let I2 _ x5 = shape a8 in x5))) in T2 (T2 (T2 (constant ()) x155) x156) x157
                      in T2 (T2 (T2 (constant ()) (min x152 x146)) (min x153 x147)) (min x154 x148)
                in I3 (min x143 x137) (min x144 x138) (min x145 x139))
               (const 0))
        a27 =
          generate
            (let T2 (T2 _ x177) x178 = let I2 x179 x180 = shape a26 in T2 (T2 (constant ()) x179) x180
                 T2 (T2 _ x181) x182 =
                   let I2 x183 x184 =
                         indexFull
                           (I2 (let T2 (T2 _ x185) _ = let I2 x186 x187 = shape a8 in T2 (T2 (constant ()) x186) x187 in x185) (constant All))
                           (shape a5)
                   in T2 (T2 (constant ()) x183) x184
             in I2 (min x181 x177) (min x182 x178))
            (\(I2 x192 x193) ->
               let T2 x194 _ =
                     let x195 =
                           let T2 _ x196 = let I1 x197 = indexSlice (I2 (let T2 (T2 _ x198) _ = let I2 x199 x200 = shape a8 in T2 (T2 (constant ()) x199) x200 in x198) (constant All)) (I2 x192 x193) in T2 (constant ()) x197
                               T2 x201 _ =
                                 let x202 = a5 ! I1 x196
                                     x203 = 0
                                     x204 = x202 + x203
                                 in T2 x204 (T2 (T2 (T2 (T2 (T2 (T2 (T2 (T2 (T2 (constant ()) x202) x203) x202) x203) x204) x202) x203) x202) x203)
                           in x201
                         x205 =
                           let x206 = a26 ! I2 x192 x193
                               T2 x207 _ = let x208 = (0.5 :: Exp Float) * x206 in T2 x208 (T2 (T2 (T2 (T2 (T2 (T2 (constant ()) x206) x208) x206) (0.5 :: Exp Float)) x206) (0.5 :: Exp Float))
                           in x207
                         x209 = x195 - x205
                     in T2 x209 (T2 (T2 (T2 (T2 (T2 (T2 (T2 (T2 (T2 (constant ()) x195) x205) x195) x205) x209) x195) x205) x195) x205)
               in x194)
        a28 = fold1 (\x210 x211 -> max x210 x211) a27
        a29 =
          generate
            (let T2 (T2 _ x212) x213 = let I2 x214 x215 = indexFull (I2 (constant All) (let T2 _ x216 = let I2 x217 x218 = shape a27 in T2 (T2 (constant ()) x217) x218 in x216)) (shape a28) in T2 (T2 (constant ()) x214) x215
                 T2 (T2 _ x219) x220 = let I2 x221 x222 = shape a27 in T2 (T2 (constant ()) x221) x222
             in I2 (min x219 x212) (min x220 x213))
            (\(I2 x223 x224) ->
               let T2 x225 _ =
                     let x226 = a27 ! I2 x223 x224
                         x227 = a28 ! indexSlice (I2 (constant All) (let T2 _ x228 = let I2 x229 x230 = shape a27 in T2 (T2 (constant ()) x229) x230 in x228)) (I2 x223 x224)
                         x231 = x226 - x227
                     in T2 x231 (T2 (T2 (T2 (T2 (T2 (T2 (T2 (T2 (T2 (constant ()) x226) x227) x226) x227) x231) x226) x227) x226) x227)
               in x225)
        a30 =
          fold
            (\x232 x233 -> x232 + x233)
            (0.0 :: Exp Float)
            (generate
               (shape a29)
               (\(I2 x234 x235) ->
                  let x236 = a29 ! I2 x234 x235
                      T2 x237 _ = let x238 = exp x236 in T2 x238 (T2 (T2 (T2 (constant ()) x236) x238) x236)
                  in x237))
        a43 = generate Z_ (\Z_ -> let x351 = 1.0 :: Exp Float in T2 (T2 x351 x351) (constant ()))
        a44 = map (\(T2 (T2 x352 _) _) -> x352) a43
        a46 = generate Z_ (\Z_ -> let x354 = a44 ! Z_ in T2 (T2 x354 (-x354)) (constant ()))
        a47 = map (\(T2 (T2 x355 _) _) -> x355) a46
        a49 =
          generate
            (let T2 _ x357 = let I1 x358 = shape a28 in T2 (constant ()) x358
                 T2 _ x359 = let I1 x360 = shape a30 in T2 (constant ()) x360
                 T2 _ x361 =
                   let T2 _ x362 = let I1 x363 = shape a28 in T2 (constant ()) x363
                       T2 _ x364 = let I1 x365 = shape a30 in T2 (constant ()) x365
                   in T2 (constant ()) (min x364 x362)
             in I1 (min x361 (min x359 x357)))
            (\(I1 x366) ->
               let x367 =
                     cond
                       ((<) x366
                            (let T2 _ x375 =
                                   let I1 x376 =
                                         indexFull
                                           (I1 (let T2 _ x377 =
                                                      let T2 _ x378 = let I1 x379 = shape a28 in T2 (constant ()) x379
                                                          T2 _ x380 = let I1 x381 = shape a30 in T2 (constant ()) x381
                                                      in T2 (constant ()) (min x380 x378)
                                                in x377))
                                           Z_
                                   in T2 (constant ()) x376
                             in x375))
                       (a47 ! Z_)
                       (0.0 :: Exp Float)
               in T2 (T2 x367 x367) (constant ()))
        a50 = map (\(T2 (T2 x382 _) _) -> x382) a49
        a51 = map (\(T2 (T2 _ x383) _) -> x383) a49
        a52 =
          generate
            (let T2 (T2 _ x384) x385 = let I2 x386 x387 = indexFull (I2 (constant All) (let T2 _ x388 = let I2 x389 x390 = shape a27 in T2 (T2 (constant ()) x389) x390 in x388)) (shape a28) in T2 (T2 (constant ()) x386) x387
                 T2 (T2 _ x391) x392 = let I2 x393 x394 = shape a27 in T2 (T2 (constant ()) x393) x394
                 T2 (T2 _ x395) x396 = let I2 x397 x398 = shape a29 in T2 (T2 (constant ()) x397) x398
             in I2 (min x395 (min x391 x384)) (min x396 (min x392 x385)))
            (\(I2 x399 x400) ->
               let x401 =
                     cond
                       (let T2 x402 x403 =
                              let T2 (T2 _ x404) x405 =
                                    let T2 (T2 _ x406) x407 = let I2 x408 x409 = shape a29 in T2 (T2 (constant ()) x408) x409
                                        T2 (T2 _ x410) x411 = let I2 x412 x413 = shape a29 in T2 (T2 (constant ()) x412) x413
                                    in T2 (T2 (constant ()) (min x410 x406)) (min x411 x407)
                              in T2 x404 x405
                        in x399 < x402 && x400 < x403)
                       (let T2 x414 _ =
                              let T2 (T2 _ x415) _ =
                                    let x416 = a29 ! I2 x399 x400
                                        T2 _ (T2 (T2 (T2 _ x417) x418) x419) = let x420 = exp x416 in T2 x420 (T2 (T2 (T2 (constant ()) x416) x420) x416)
                                    in T2 (T2 (T2 (constant ()) x417) x418) x419
                              in T2 ((*) (cond
                                            (let T2 x456 x457 = let T2 (T2 _ x458) x459 = let I2 x460 x461 = indexFull (I2 (constant All) (let T2 _ x462 = let I2 x463 x464 = shape a29 in T2 (T2 (constant ()) x463) x464 in x462)) (shape a30) in T2 (T2 (constant ()) x460) x461 in T2 x458 x459 in x399 < x456 && x400 < x457)
                                            (let T2 _ x465 = let I1 x466 = indexSlice (I2 (constant All) (let T2 _ x467 = let I2 x468 x469 = shape a29 in T2 (T2 (constant ()) x468) x469 in x467)) (I2 x399 x400) in T2 (constant ()) x466
                                             in cond
                                                  ((<) x465
                                                       (let T2 _ x475 =
                                                              let T2 _ x476 = let I1 x477 = shape a30 in T2 (constant ()) x477
                                                                  T2 _ x478 = let I1 x479 = shape a30 in T2 (constant ()) x479
                                                              in T2 (constant ()) (min x478 x476)
                                                        in x475))
                                                  (let T2 x480 _ =
                                                         let T2 _ x481 =
                                                               let x482 = a30 ! I1 x465
                                                                   T2 _ (T2 (T2 (T2 _ x483) x484) x485) = let x486 = log x482 in T2 x486 (T2 (T2 (T2 (constant ()) x482) x486) x482)
                                                               in T2 (T2 (T2 (constant ()) x483) x484) x485
                                                         in T2 (cond (x465 < (let T2 _ x487 = let I1 x488 = shape a30 in T2 (constant ()) x488 in x487)) (cond (x465 < (let T2 _ x489 = let I1 x490 = shape a50 in T2 (constant ()) x490 in x489)) (a50 ! I1 x465) (0.0 :: Exp Float)) (0.0 :: Exp Float) / x481) (constant ())
                                                   in x480)
                                                  (0.0 :: Exp Float))
                                            (0.0 :: Exp Float))
                                         x415)
                                    (constant ())
                        in x414)
                       (0.0 :: Exp Float)
               in T2 (T2 x401 (-x401)) (constant ()))
        a54 = map (\(T2 (T2 _ x492) _) -> x492) a52
        a56 = fold1 (\x507 x508 -> x507 + x508) (generate (indexFull (I2 (constant All) (let T2 _ x509 = let I2 x510 x511 = shape a27 in T2 (T2 (constant ()) x510) x511 in x509)) (shape a28)) (\(I2 x512 x513) -> cond (let T2 x514 x515 = let T2 (T2 _ x516) x517 = let I2 x518 x519 = indexFull (I2 (constant All) (let T2 _ x520 = let I2 x521 x522 = shape a27 in T2 (T2 (constant ()) x521) x522 in x520)) (shape a28) in T2 (T2 (constant ()) x518) x519 in T2 x516 x517 in x512 < x514 && x513 < x515) (cond (let T2 x523 x524 = let T2 (T2 _ x525) x526 = let I2 x527 x528 = shape a54 in T2 (T2 (constant ()) x527) x528 in T2 x525 x526 in x512 < x523 && x513 < x524) (a54 ! I2 x512 x513) (0.0 :: Exp Float)) (0.0 :: Exp Float)))
        a57 = generate (shape a28) (\(I1 x529) -> cond (x529 < (let T2 _ x530 = let I1 x531 = shape a56 in T2 (constant ()) x531 in x530)) (a56 ! I1 x529) (0.0 :: Exp Float))
        a58 = generate (shape a28) (\(I1 x532) -> cond (x532 < (let T2 _ x533 = let I1 x534 = shape a28 in T2 (constant ()) x534 in x533)) (cond (x532 < (let T2 _ x535 = let I1 x536 = shape a51 in T2 (constant ()) x536 in x535)) (a51 ! I1 x532) (0.0 :: Exp Float)) (0.0 :: Exp Float))
        a59 = scanl1 (\x537 x538 -> max x537 x538) a27
        a60 = backpermute (let T2 x539 x540 = let T2 (T2 _ x541) x542 = let I2 x543 x544 = shape a59 in T2 (T2 (constant ()) x543) x544 in T2 x541 x542 in I2 x539 ((-1 :: Exp Int) + x540)) (\(I2 x545 x546) -> I2 x545 x546) a59
        a61 =
          scanr
            (\x547 x548 -> x547 * x548)
            (1.0 :: Exp Float)
            (generate
               (let T2 x549 x550 = let T2 (T2 _ x551) x552 = let I2 x553 x554 = shape a27 in T2 (T2 (constant ()) x553) x554 in T2 x551 x552
                    T2 (T2 _ x555) x556 = let I2 x557 x558 = shape a60 in T2 (T2 (constant ()) x557) x558
                in I2 (min x555 x549) (min x556 ((-1 :: Exp Int) + x550)))
               (\(I2 x559 x560) -> let T2 x561 _ = cond (a60 ! I2 x559 x560 > a27 ! I2 x559 ((1 :: Exp Int) + x560)) (T2 (1.0 :: Exp Float) (0.0 :: Exp Float)) (T2 (0.0 :: Exp Float) (1.0 :: Exp Float)) in x561))
    in
          generate
            (shape a27)
            (\(I2 x562 x563) ->
               cond
                 (let T2 x564 x565 =
                        let T2 (T2 _ x566) x567 =
                              let T2 (T2 _ x568) x569 =
                                    let T2 x570 x571 =
                                          let T2 (T2 _ x572) x573 =
                                                let T2 x574 x575 = let T2 (T2 _ x576) x577 = let I2 x578 x579 = shape a27 in T2 (T2 (constant ()) x578) x579 in T2 x576 x577
                                                    T2 (T2 _ x580) x581 = let I2 x582 x583 = shape a60 in T2 (T2 (constant ()) x582) x583
                                                in T2 (T2 (constant ()) (min x580 x574)) (min x581 ((-1 :: Exp Int) + x575))
                                          in T2 x572 x573
                                        T2 (T2 _ x584) x585 = let I2 x586 x587 = shape a61 in T2 (T2 (constant ()) x586) x587
                                    in T2 (T2 (constant ()) (min x570 x584)) (min ((1 :: Exp Int) + x571) x585)
                                  T2 (T2 _ x588) x589 =
                                    let I2 x590 x591 =
                                          indexFull
                                            (I2 (constant All)
                                                (let T2 _ x592 =
                                                       let T2 x593 x594 =
                                                             let T2 (T2 _ x595) x596 =
                                                                   let T2 x597 x598 = let T2 (T2 _ x599) x600 = let I2 x601 x602 = shape a27 in T2 (T2 (constant ()) x601) x602 in T2 x599 x600
                                                                       T2 (T2 _ x603) x604 = let I2 x605 x606 = shape a60 in T2 (T2 (constant ()) x605) x606
                                                                   in T2 (T2 (constant ()) (min x603 x597)) (min x604 ((-1 :: Exp Int) + x598))
                                                             in T2 x595 x596
                                                           T2 (T2 _ x607) x608 = let I2 x609 x610 = shape a61 in T2 (T2 (constant ()) x609) x610
                                                       in T2 (T2 (constant ()) (min x593 x607)) (min ((1 :: Exp Int) + x594) x608)
                                                 in x592))
                                            (shape a28)
                                    in T2 (T2 (constant ()) x590) x591
                              in T2 (T2 (constant ()) (min x588 x568)) (min x589 x569)
                        in T2 x566 x567
                  in x562 < x564 && x563 < x565)
                 ((*) (let T2 _ x644 =
                             let I1 x645 =
                                   indexSlice
                                     (I2 (constant All)
                                         (let T2 _ x646 =
                                                let T2 x647 x648 =
                                                      let T2 (T2 _ x649) x650 =
                                                            let T2 x651 x652 = let T2 (T2 _ x653) x654 = let I2 x655 x656 = shape a27 in T2 (T2 (constant ()) x655) x656 in T2 x653 x654
                                                                T2 (T2 _ x657) x658 = let I2 x659 x660 = shape a60 in T2 (T2 (constant ()) x659) x660
                                                            in T2 (T2 (constant ()) (min x657 x651)) (min x658 ((-1 :: Exp Int) + x652))
                                                      in T2 x649 x650
                                                    T2 (T2 _ x661) x662 = let I2 x663 x664 = shape a61 in T2 (T2 (constant ()) x663) x664
                                                in T2 (T2 (constant ()) (min x647 x661)) (min ((1 :: Exp Int) + x648) x662)
                                          in x646))
                                     (I2 x562 x563)
                             in T2 (constant ()) x645
                       in cond (x644 < max (let T2 _ x665 = let I1 x666 = shape a58 in T2 (constant ()) x666 in x665) (let T2 _ x667 = let I1 x668 = shape a57 in T2 (constant ()) x668 in x667)) (cond ((0 :: Exp Int) == (let T2 _ x669 = let I1 x670 = shape a58 in T2 (constant ()) x670 in x669)) (a57 ! I1 x644) (cond ((0 :: Exp Int) == (let T2 _ x671 = let I1 x672 = shape a57 in T2 (constant ()) x672 in x671)) (a58 ! I1 x644) (a58 ! I1 x644 + a57 ! I1 x644))) (0.0 :: Exp Float))
                      ((*) (cond
                              (x563 > (0 :: Exp Int))
                              (let x675 = (-1 :: Exp Int) + x563
                                   T2 _ x676 = cond (a60 ! I2 x562 x675 > a27 ! I2 x562 ((1 :: Exp Int) + x675)) (T2 (1.0 :: Exp Float) (0.0 :: Exp Float)) (T2 (0.0 :: Exp Float) (1.0 :: Exp Float))
                               in x676)
                              (1.0 :: Exp Float))
                           (a61 ! I2 x562 x563)))
                 (0.0 :: Exp Float))
