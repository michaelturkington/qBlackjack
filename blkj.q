system "S ",4_-4_string `long$.z.n
c:raze 4#'(`A`2`3`4`5`6`7`8`9`10`J`Q`K)
cval:(`2`3`4`5`6`7`8`9`10`J`Q`K)!(2 3 4 5 6 7 8 9 10 10 10 10)
win:0
lose:0
draw:0
games:0
cash:100
record:(`games`win`lose`draw`bet`cash)!(6#())
hnds:(`playerayer`dealer)!(();())

blackjack:{ [x] if[ (cash<x) | (0=cash) ; '"Get more money you bum!" ] ;
        if[ 0>x ; '"Don't try any funny business!" ] ;
	show "Welcome to Q blackjack!" ;
        show "Type hit[] to get another card or stand[] to hold." ;
        d::-52?c ;
        hnds[`player]:() ;
        hnds[`dealer]:() ;
        bet::x ; 
        record::record,'(games;win;lose;draw;bet;cash) ;
	deal[]
 }

deal:{ 	do[2;take[`player];take[`dealer]] ;
        show "Player has";
        ctot[`player] ;
        if[21=total[hnds[`player]] ; show "Blackjack!" ;
	   win::win+1 ; cash::cash+(1.5*bet) ; games:: games+1 ;
	   show "Player cash: ",string cash ]
 }

hit:{	take[`player] ;
	ctot[`player] ;
        if[21<total[hnds[`player]] ; show "Bust!" ; wins[`dealer] ]
 }

stand:{ show "Dealer has" ;
	ctot[`dealer] ;
	while[17>total[hnds[`dealer]] ; ddeal[] ] ;
	if[21<total[hnds[`dealer]]; wins[`player] ] ;
        if[total[hnds[`dealer]] within 17 21 ; check[] ]

 }

ddeal:{ system "sleep 1" ;
	show "Dealer draws" ;
	take[`dealer] ;
	ctot[`dealer] 
 }

check:{ if[total[hnds[`player]]>total[hnds[`dealer]]; wins[`player]] ;
	if[total[hnds[`player]]<total[hnds[`dealer]]; wins[`dealer]] ;
	if[total[hnds[`player]]=total[hnds[`dealer]]; show "Draw" ;
	   draw::draw+1 ; show "Player cash: ",string cash ; games::games+1 ]
 }

take:{  [x] t:1#d ; d::1_d ; hnds[x]::hnds[x],t }

total:{	[x] s::0 ; {$[ `A~x ; s::distinct raze s+/:1 11 ; s::s+cval[x] ]} each x ;
	$[ 1<count s ; $[ 0=count t:s where 22>s ; min s ; max t ] ; s ]
 }

ctot:{	[x] show hnds[x] ;
	t:total[hnds[x]] ;
	$[ `player~x ; show "Player total: ",string t ;
	   show "Dealer total: ",string t ]
 }

wins:{	[x] $[`player~x ;
	[show "Player wins!" ; win::win+1 ; cash::cash+bet ] ;
	[show "Dealer wins!" ; lose::lose+1 ; cash::cash-bet ] ] ;
	show "Player cash: ",string cash ;
	games::games+1 ;
 }


