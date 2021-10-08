library ieee;
use ieee.std_logic_1164.all;

entity diff8 is
   port(Rq : in std_logic_vector(15 downto 0);
	r,q :out std_logic_vector(7 downto 0));
end entity diff8;

architecture beh of diff8 is
signal tq1: std_logic_vector(15 downto 0);

begin
   tq1 <= Rq;
   r <= tq1(15 downto 8);
	q <= tq1(7 downto 0);

end beh;

library ieee;
use ieee.std_logic_1164.all;
entity diff2 is
   port(Rq : in std_logic_vector(7 downto 0);
	     q : out std_logic_vector(1 downto 0));
end entity diff2;

architecture beh2 of diff2 is
begin
   q <= Rq(1 downto 0);
	
end beh2;

library ieee;
use ieee.std_logic_1164.all;
entity diff1 is
   port(Rq : in std_logic_vector(7 downto 0);
	q : out std_logic_vector(0 downto 0));
end entity diff1;

architecture beh of diff1 is

begin

   q <= Rq(0 downto 0);
	
end beh;

library ieee;
use ieee.std_logic_1164.all;
entity diff6 is
   port(Rq : in std_logic_vector(7 downto 0);
	q : out std_logic_vector(5 downto 0));
end entity diff6;

architecture beh of diff6 is

begin

   q <= Rq(5 downto 0);
	
end beh;

library ieee;
use ieee.std_logic_1164.all;
library work;
entity zero is
   port(K1 : in std_logic;
	     K2 : out std_logic);
end entity zero;

architecture behav of zero is
component AND_2 is
   port (A, B: in std_logic; Y: out std_logic);
  end component AND_2;
begin
   p : AND_2 port map(A => K1, B => '0', Y => K2);
end behav;

library ieee;
use ieee.std_logic_1164.all;
library work;
entity atm is

   port(M :in std_logic_vector(7 downto 0);
	a :out std_logic_vector(1 downto 0);
	b :out std_logic_vector(0 downto 0);
	c :out std_logic_vector(5 downto 0);
	P1 :out std_logic;
	P2 :out std_logic);
	
-- port declaration 
end entity atm;

architecture struct of atm is

signal x1,x2,x3: std_logic_vector(15 downto 0);
signal t1,t2,t3,t4,t5,t6 : std_logic_vector(7 downto 0);

component div is
generic(
			N : integer:=8; -- operand width
			NN : integer:=16 -- result width
        );
port (
			Nu: in std_logic_vector(N-1 downto 0);-- Nu (read numerator) is dividend
			D: in std_logic_vector(N-1 downto 0);-- D (read Denominator) is divisor
			RQ: out std_logic_vector(NN-1 downto 0)--upper N bits of RQ will have remainder and lower N bits will have quotient
) ;
end component;

component diff8 is
port(Rq : in std_logic_vector(15 downto 0);
	r,q :out std_logic_vector(7 downto 0));
end component;
component diff2 is
   port(Rq : in std_logic_vector(7 downto 0);
	q : out std_logic_vector(1 downto 0));
end component;

component diff1 is
   port(Rq : in std_logic_vector(7 downto 0);
	q : out std_logic_vector(0 downto 0));
end component;

component diff6 is
   port(Rq : in std_logic_vector(7 downto 0);
	q : out std_logic_vector(5 downto 0));
end component;

component zero is
   port(K1 : in std_logic;
	     K2 : out std_logic);
end component;

signal l1,l2 : std_logic;
-- write code here

begin

   q100 : div port map(Nu => M, D => "01100100", RQ => x1);
	r100 : diff8 port map(Rq => x1, r => t1, q => t2);
   r100_2 : diff2 port map( Rq => t2, q => a);	
	q50 : div port map(Nu => t1, D => "00110010", RQ => x2);
	r50 : diff8 port map(Rq => x2, r=> t3, q => t4);
	r50_1 : diff1 port map(Rq => t4, q => b);
	q1 : div port map(Nu => t3, D => "00000001", RQ => x3);
	r1:  diff8 port map(Rq => x3, r => t5, q => t6);
	r1_6 : diff6 port map( Rq => t6, q => c);
	pq1: zero port map(K1 => l1, K2 =>P1);
	pq2 : zero port map(K1 => l2, K2 => P2);
	
-- Write code here(don't worry about generic, just ignore it and do normal port mapping for div)

end struct;
   
   