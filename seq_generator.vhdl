library ieee;
use ieee.std_logic_1164.all;
package Flipflops is
  component dff_set is port(D,clock,set:in std_logic;Q:out std_logic);
  end component dff_set;
  component dff_reset is port(D,clock,reset:in std_logic;Q:out std_logic);
  end component dff_reset;
  --write the component instantiation for the entity dff_reset
 end package Flipflops;
 
--D flip flop with set
library ieee;
use ieee.std_logic_1164.all;

entity dff_set is port(D,clock,set:in std_logic;Q:out std_logic);
end entity dff_set;

architecture behav of dff_set is
begin
dff_set_proc: process (clock,set)
begin
if(set='1')then -- set implies flip flip output logic high
Q <= '1'; 
elsif (clock'event and (clock='1')) then               
Q <= D;
end if ;
end process dff_set_proc;
end behav;

--D flip flop with reset
library ieee;
use ieee.std_logic_1164.all;

entity dff_reset is port(D,clock,reset:in std_logic;Q:out std_logic);
end entity dff_reset;

architecture behav of dff_reset is
begin
dff_reset_proc: process (clock,reset) --write the sensitivity list
begin
if(reset='1')then -- reset implies flip flip output logic low
Q <= '0'; -- write the D Flipflop output when reset
elsif (clock'event and (clock='1')) then                         
Q <= D; ---- write the D Flipflop output when posedge clock is triggered end if ;
end if;
end process dff_reset_proc;
end behav;


library ieee;
use ieee.std_logic_1164.all;
use work.Flipflops.all;
-- write the Flipflops package declaration

entity Sequence_generator_stru_dataflow is
port (reset,clock: in std_logic;
y:out std_logic_vector(2 downto 0));
end entity Sequence_generator_stru_dataflow;

architecture struct of Sequence_generator_stru_dataflow is 
signal D :std_logic_vector(2 downto 0); -- D flip flop inputs
signal Q:std_logic_vector(2 downto 0);  -- D flip flop outputs
signal Qnot:std_logic_vector(2 downto 0);
signal P:std_logic;
begin

-- write the eqations in dataflow  e.g z=a+bc written z<= a or (b and c)
Qnot(2) <= not Q(2);
Qnot(1) <= not Q(1);
Qnot(0) <= not Q(0);
P <= Q(1) xor Q(0);

D(2) <= Q(2) xnor P;

D(1) <= (Q(2) and Qnot(0)) or (Qnot(2) and Qnot(1));

D(0) <= (Qnot(2) and Q(0)) or (Q(2) and Q(1));
                                                                                                      
y(2) <= Q(2);       
y(1) <= Q(1);
y(0) <= Q(0);                                                                             

--Q0
dff_0  : dff_reset port map(D(0),clock,reset,Q(0)); 

--Q1
dff_1  : dff_set port map(D(1),clock,reset,Q(1));

--Q2
dff_2  : dff_set port map(D(2),clock,reset,Q(2));
end struct;                               