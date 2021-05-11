#!/bin/bash

function main()
{
    make clean
    check_number
    make

    diff -B -b \
        --unchanged-line-format="" \
        --old-line-format="Answer : Line[%6dn] %L" \
        --new-line-format="Result : Line[%6dn] %L" \
        answer.txt result.txt

    RETVAL=$?

    if [[ -e "./result.txt" ]]; then
        if [[ $RETVAL == 1 ]]; then
            echo -e "\e[1;31mYOUR ANSWER IS WRONG!!\e[0m"

            Wrong
        elif [[ $RETVAL == 0 ]]; then
            echo -e "\e[1;32mCONGRATULATION!!\e[0m"

            Correct
        else
            echo "Diff Error"
        fi
    else
        echo -e "\e[1;31mCompile Error, Can't Find 'result.txt'\e[0m"
        NoResult
    fi
}

function check_number()
{
    PWD=$(basename $(pwd))
    for x in $(ls *.v); do
        COUNT=$(cat $x | grep $PWD | wc -l)

        if [[ $COUNT -le 0 ]]; then
            echo -e "\e[1;31m$x WRONG STUDENT ID\e[0m"
            echo -e "\e[1;33mR U COPY CAT ???\e[0m"

            CopyCat

            exit 1
        fi
    done
}




















































































































































































function Correct()
{
    echo "MMMMMMMMMMMMMMMMMMMWXKOOkkOO0XWMMMMMMMMMMMMMMMMMMM"
    echo "MMMMMMMMMMMMMW0dc:::ccllllllcc:::coONMMMMMMMMMMMMM"
    echo "MMMMMMMMMMWk:;lk0NNNNNNNNNNNNNNNNKko;:dNMMMMMMMMMM"
    echo "MMMMMMMMMO'cONNNNNNNNNNNNNNNNNNNNNNNNKl'xWMMMMMMMM"
    echo "MMMMMMMNc'ONNNNNNNNKXNNNNNNNNNXXNNNNNNN0;;XMMMMMMM"
    echo "MMMMMMW;,KNNNNNNNN0.xNNNNNNNNNl;NNNNNNNNXc'NMMMMMM"
    echo "MMMMWKl.;dXNN0lNNNd.KNNNNNNNNNx.KNNdkNNNxc.:KWMMMM"
    echo "MMXl,cl...0NNd.:::;,::::::::::;,:::.cNNX'..cc;cKMM"
    echo "Wo'oXNNk.,NNNd'WWWWWWWWWWWWWWWWWWWWc:NNNc.dNNNx'cN"
    echo "O;;.ONX,.:NNNo,Wk:NWWWWWWWWWWWWWooWl;NNNo.'0NK.,;k"
    echo "MM0.0x,c.cNNNo,Wl.XWWWWWWWWWWWWW,,Wl,KNNx.:'oK'xMM"
    echo "MMX.,.:0.lNNNo,Wo'XWWWWWWWWWWWWW::Wl'ONN0.do.,.0MM"
    echo "MMMNN.ox.oXNNo,WWWWWWWWWWWWWWWWWWWWl,kKNX.lk.0NMMM"
    echo "MMMM0.kl.xKNNo'WWWWWWWNcoocKWWWWWWWl,kONN:;K.dMMMM"
    echo "MMMMd.K:,xoKNd'WWWWWWWWXOkKWWWWWWWWc,kxxKo'N;:MMMM"
    echo "MMMM;:N'.','0d.;codxxkkkOOOOkkxdoc;.;d'.,..Kd.WMMM"
    echo "MMMN.xNkOXk,.'..kOkxd..looo'.oxkO0'...;xN0xX0.0MMM"
    echo "MMMx'XNNNNNO....,:oxOO:.dx';kOxo:,..'.kNNNNNN:lMMM"
    echo "MMW;lNXOK0x..:..:;,,''.......',,;:'.;,.o0KOXNx.NMM"
    echo "MMO.cc'.ox'.:;.,::::::::::::::::::;.,:'.dx..:l.dMM"
    echo "MMN0OKl'x,.;:,.;:::::::::::::::::::.'::'.d:;X0ONMM"
    echo "MMMMMW';;.Oko,.::::::::::::::::::::''ox0;':.KMMMMM"
    echo "MMMMMWxoc.,lx,.:::::::::::::::::ccc,.xo;.;odXMMMMM"
    echo "MMMMMMMMk.0k..,:::::::::::::::ccccc:..dK,lMMMMMMMM"
    echo "MMMMMMMMX'....,::::::::::::::ccccccc.....OMMMMMMMM"
}

function Wrong()
{
    echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMk.kWMMMMMMMMM0OMMMM"
    echo "MMMMMMMMMMMMMMNolxNMMMXO0WMMMM0....:MMMMMMN,..dMMM"
    echo "MMMMMMMMMMMMMMx....xWc...oMMMW'''.l0MMMMMM:....WMM"
    echo "MMMMMMMMMMMMMMW:.''...''.:MMMx...cMMMMMMMO.,.xNMMM"
    echo "MMMMMMMMMMMMMMWK,........';;,.,x,'cc:::cd,'..XMMMM"
    echo "MMMMMMMMMMMNx;',:lodxkO,.''''...',::;;,,,.;o'MMMMM"
    echo "MMMMMMMMNx:.;dOOOOOOOOOd..''''..,;l:;;;;cc'.;MMMMM"
    echo "MMMMMMMN.;okOOOOOOOOOOOO;.'''''..;lc::::l:;;.OMMMM"
    echo "MMMMMMW;;OOOOOOOOkxxxOOOo.''''''.'lcccclllc:';MMMM"
    echo "MMMMMMx'kOkoc;''''','.'lk..''''''.c:;;;:l::c:.NMMM"
    echo "MMMMMMc;c,.;ldxkkdoc:,..;.........';;;;cc;;;;.XMMM"
    echo "MMMMKo.':dkdc,..,:l:.lkOdllodkOKXk.''..,;;;;''MMMM"
    echo "MMK;'ldl:'..,d.oXXXo..xXXXXXXXXXXXd.0WKx;.';.xMMMM"
    echo "MMk,'..:..,OWWK':xk'xO'';X0.KXXXXXOl.KMMMNl.,MMMMM"
    echo "MMMMK.x:,0WWWWWNklcdWxdx.0X,lXXXXXd..'WMMMX.0MMMMM"
    echo "MMMW:;x.0lWWWWWWWWWWN.xW.xXl:XXXXXX'..XMM0'dMMMMMM"
    echo "MMW,;K,dd'WWWWWWWWWWX;XW;oXl;XXKkx;,KNMK:'OMMMMMMM"
    echo "Kl,.;l.XX0WWWWWWWWWWWWWW:lX:c0l.:cdWMNc'kWMMMMMMMM"
    echo ".dK:;..0WWWWWWWd',NWWWWW,ld..;xXMMMM0'oWMMMMMMMMMM"
    echo ".ll'd:.,NWWWWWWWXNWWWKkl...;NMMMMMO;.OMMMMMMMMMMMM"
    echo "0,.oc.0l'oOKKK0kxo:;,'.oo.0.OMMWk;;oNMMMMMMMMMMMMM"
    echo "MMOoc;,,..':::coxOKWMl;kc.0,cOc'cKMMMMMMMMMMMMMMMM"
    echo "MMMMMMMMWWWMMMMMMMMMMO,..''.,lOWMMMMMMMMMMMMMMMMMM"
    echo "MMMMMMMMMMMMMMMMMMMMMMWKNWMMMMMMMMMMMMMMMMMMMMMMMM"
    echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
}

function CopyCat()
{
    echo "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"
    echo "WWWWWWWWWWWWWWWK0NWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"
    echo "WWWWWWWWWWWWWX.   ,0WWWWXXKXNWWWWWNkoxWWWWWWWWWWWW"
    echo "WWWWWWWWWWWWM; :;'. ;'.       .lx,... .WWWWWWWWWWW"
    echo "WWWWWWWWWWWWM'.c;,;,',;;,;,;;;,.'::;;' OWWWWWWWWWW"
    echo "WWWWWWWWWWWWW0 ..,,,,;''c':,,';;;;;;' .NWWWWWWWWWW"
    echo "WWWWWWWWWWWWWO.'c;'dokcdkdkxkd';;:;;..NWWWWWWWWWWW"
    echo "WWWWWWWWWWWWk ;oc,..,,',;';;,,.;:dl,,.cMWWWWWWWWWW"
    echo "WWWWWWWWWWW0 ;;;'l;,;;;;;;;;; o',::,., kWWWWWWWWWW"
    echo "WWWWWWWWWWN.';,,OK',,,,,,,,,,'O0,,;;,'..WWWWWWWWWW"
    echo "WWWWWWWWWM: ;;,KNNXXXXXXXXXXXNNNl,;;;., kWWWWWWWWW"
    echo "WWWWWWWWXk ';,oNN: ONNNNNNNNl.oN;;;;;''.:WWWWWWWWW"
    echo "WWWWWWWN   ;c'kNN.'NNNNNNNNX;'kX';;o;,...MWWWWWWWW"
    echo "WWWWWWWM: .:d'0N0:dNNNNNNNN0:cXO.;;d;;., 0WWWWWWWW"
    echo "WWWWWWWWK ;kO;KNkl0NNNNNNNNOcdNd'cd0dc.d.lWWWWWWWW"
    echo "WWWWWWWW0 lOO;KNNNNNNNNNNNNNNNNccxkKxx.  NWWWWWWWW"
    echo "WWWWWWWW0 dkO,KNNNN0xdooooxKNNX,dxkOxx., XWWWWWWWW"
    echo "WWWWWWWWK oxxc;0NNklkOO0XKkcKNK,xxkxxx., KWWWWWWWW"
    echo "WWWWWWWWM.:xkxo,;dOkkkxoNXdkXNK,xxkkx:., OWWWWWWWW"
    echo "WWWWWWWWWo.xkxxxo  .,cxdOkxoc,. dxxxx.', dWWWWWWWW"
    echo "WWWWWWWWWN ;xxxx;     'OkOo     :xxx; ., lWWWWWWWW"
    echo "WWWWWWWWWWx lxxl     :OkooOd.    oxc  ., :WWWWWWWW"
    echo "WWWWWWWWWWM, o:     oOOoXXd0O'   .:   ., 'MWWWWWWW"
    echo "WWWWWWWWWWW...     o0;'lMMc:KX;        , .MWWWWWWW"
    echo "WWWWWWWWWWWKXXXXXXXWWXNNWWNXWWWXXXXXXXXNXXWWWWWWWW"
    echo "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"
}

function NoResult()
{
    echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    echo "XXXXXXXXXXXXXXXXX0''dXX0KXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    echo "XXXXXXXXXXXXXXXXXK'..:...0XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    echo "XXXXXXXXX0dccllcllc,,,'..odOXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    echo "XXXXXXXk:cdOOOOOOOOOOOk.'''.:KXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    echo "XXXXXKo.llcccccccccldOO'''''.,KXXXXXXXXXXOkdoooooooxk0XXXXXXXXXXX"
    echo "XXXl';,,;:cllllllll:'.;...'''.dXXXXXKolooxOKNNNNNNX0kdooloOooOXXX"
    echo "XXXKo.kXXX0OkocXXXk;kXX00Oxdl,lXX0oo;:x0NNNNNNKkNNNNk0NNNK,lXllXX"
    echo "XXXX,OXXXo,oONkcoo,xdcdkXXXXXK'0X,;dNk..KNNNXKO.xOOOl;O0NNN;OK;,0"
    echo "XXXk,XXK;okWWWWWWNNW:0O,XldXXXO,OK'XNN;:NX.ldkOO000000kd;0Nk:0'KX"
    echo "XXO,KXX,OoxWWWWWWWWWoNK,XldXXXXO,O:oO:.ONNcx;XWWWWWWWWlcX,KK'clXX"
    echo "XX:xXXdoWWWWWWN;,XWWWWk:K'KXX0:',OO'xO.0NNO:dOWWWWWWWWN0WK,XolXXX"
    echo "XXo,'xO;KWWWWWW0oOkdcl.;,'cllo0XXXolNX.lkNN'XWWWWOc0WWWWWW;Ok.KXX"
    echo "XXXXKxlcco:,c:.,..:W,dooO;oXXXXXXX'KNNxl'0Nd:kxxxddddoloo'co;okXX"
    echo "XXx:;;,'..........cd:,,;O:.KXXXXXdc0ONNN:.:l.,lc.:.l:..,x.,,dOll0"
    echo "XX0ccc.l.,,;dx;:.oo;OOOOx':cXXXXXoc,oNNx..:;''............':d0kXX"
    echo "XXXXXK.:.l'dOO:x;..cccc::xO'OXXXXXXk;NX.;.;:xc:'..',;;.:cccXXXXXX"
    echo "XXXXXXxcxk.kOOc;dlodo;'kOOOl'KXXXXXXx:;':;''c.c,.:::::':'.'XXXXXX"
    echo "XXXXXXXXXX.,::,';;::;;';lc,''lXXXXXXX0.:::::::'''::::c,:X0XXXXXXX"
    echo "XXXXXXXXXX.ccclcccclccccc:cc:.KXX00XXo'::::::::::::::::.KXXXXXXXX"
    echo "XXXXXXXXXXc'',:;;;:c;;;;c,'',c0XX'.Ok';dxxxdoolllllodxl.dXXXXXXXX"
    echo "XXXXXXXXXXXO':.ooooooddodd..dXXXXc..'::;.;;;ooooodooo:,c:oKXXXXXX"
    echo "XXXXXXXXXXXXo..XXXXXXXXXXk..oXXXK,',cc::oc;.,oXXXXXXXXk,.cXXXXXXX"
    echo "XXXXXXXXXXXO';cXXXXXXXXXX0dd0XXXXXXXXXXXXXOoxKXXXXXXXXXXXXXXXXXXX"
    echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

main
