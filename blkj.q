system "S ",4_-4_string `long$.z.n
c:raze 4#'(`A`2`3`4`5`6`7`8`9`10`J`Q`K)
cval:(`2`3`4`5`6`7`8`9`10`J`Q`K)!(2 3 4 5 6 7 8 9 10 10 10 10)
win:0
lose:0
draw:0
games:0
cash:100
record:(`games`win`lose`draw`bet`cash)!(6#())
hnds:(`player`dealer)!(();())
f:0
ante:0

startgame:{ f::0 ; ante::"F"$input"Place your bet" ;
	blackjack[ante] 
 }

blackjack:{ [x] if[ (cash<x) | (0=cash) ; '"Get more money you bum!" ] ;
        if[ 0>x ; '"Don't try any funny business!" ] ;
	show "Welcome to Q blackjack!" ;
        show "Type hit[] to get another card or stand[] to hold." ;
	{ [y] hnds[y]:() } each `player`dealer ;
        d::-52?c ;
        bet::x ; 
        record::record,'(games;win;lose;draw;bet;cash) ;
	deal[]
 }

deal:{ 	do[2;take[`player];take[`dealer]] ;
        ctot[`player] ;
        if[21=total[`player] ; wins[`blackjack] ]
 }

hit:{	ttot[`player] ;
        if[21<total[`player] ; wins[`bust] ]
 }

stand:{	while[17>total[`dealer] ; ddeal[] ] ;
	if[21<total[`dealer]; wins[`player] ] ;
        if[total[`dealer] within 17 21 ; check[] ]
 }

ddown:{ bet::2*bet ;
	ttot[`player] ;
	if[ 21<total[`player] ; wins[`bust] ] ;
	stand[]
 }

ddeal:{ system "sleep 1" ; show "Dealer draws" ; ttot[`dealer] }

check:{ if[total[`player]>total[`dealer]; wins[`player]] ;
	if[total[`player]<total[`dealer]; wins[`dealer]] ;
	if[total[`player]=total[`dealer]; wins[`draw]] ;
 }

take:{  [x] t:1#d ; d::1_d ; hnds[x]::hnds[x],t }

total:{	[x] h:hnds[x] ; s::0 ; {$[ `A~x ; s::distinct raze s+/:1 11 ; s::s+cval[x] ]} each h ;
	$[ 1<count s ; $[ 0=count t:s where 22>s ; min s ; max t ] ; s ] }

ctot:{	[x] show $[ `player~x ; "Player has" ; "Dealer has " ] ;
        show hnds[x] ;
	t:total[x] ;
	$[ `player~x ; show "Player total: ",string t ;
	   show "Dealer total: ",string t ]
 }

ttot:{ [x] take[x] ; ctot[x] }

wins:{	[x] if[`player~x ; show "Player wins!" ; win::win+1 ; cash::cash+bet ] ;
	if[`dealer~x ; ctot[`dealer] ; show "Dealer wins!" ; lose::lose+1 ; cash::cash-bet ] ;
	if[`draw~x ; show "Draw" ; draw::draw+1 ] ;
	if[`blackjack~x ; show "Blackjack!" ; win::win+1 ; cash::cash+1.5*bet ] ;
	if[`bust~x ; show "Bust!" ; lose::lose+1 ; cash::cash-bet ] ;
	show "Player cash: ",string cash ;
	games::games+1 ; continue[]
 }

input:{ -2 x; read0 0}

newgame:{ f::string input"New game? (y/n)" }

continue:{ while[1<>sum not raze/["yn"=\:f];newgame[] ] ;
	if[any raze/["y"=f];startgame[]];
	if[any raze/["n"=f];exit 0];
 }

startgame[]
