library ieee;
use ieee.std_logic_1164.all;

entity alu_beh is
    generic(
        operand_width : integer:=4;
        sel_line : integer:=2
        );
    port (
        A: in std_logic_vector(operand_width-1 downto 0);
        B: in std_logic_vector(operand_width-1 downto 0);
        sel: in std_logic_vector(sel_line-1 downto 0);
        op: out std_logic_vector((operand_width*2)-1 downto 0)
    ) ;
end alu_beh;

architecture a1 of alu_beh is



function sub(A: in std_logic_vector(operand_width-1 downto 0); B: in std_logic_vector(operand_width-1 downto 0))
        return std_logic_vector is

            variable diff : std_logic_vector(operand_width*2-1 downto 0):= (others=>'0');
				variable aa : std_logic_vector((operand_width*2)-1 downto 0):= (others=>'0');
				variable bb : std_logic_vector((operand_width*2)-1 downto 0):= (others=>'0');
            variable carry : std_logic:= '1';
        begin
				aa(3 downto 0):= A;
            bb(3 downto 0):= B;
				-- Hint: Use for loop to calculate value of "diff" and "carry" variable
            -- Use aggregates to assign values to multiple bits
				for i in 0 to 7 loop
					diff(i) := aa(i) xor (not bb(i)) xor carry;
					carry := (aa(i) and (not bb(i))) or ((not bb(i)) and carry) or (carry and aa(i));
				end loop;
            return diff;
    end sub;

     
    function rolf(A: in std_logic_vector(operand_width-1 downto 0); B: in std_logic_vector(operand_width-1 downto 0))
        return std_logic_vector is
            variable shift : std_logic_vector((operand_width*2)-1 downto 0):= (others=>'0');
            variable tmp : integer := 0;
	

        begin
            
	
				for i in 0 to 2 loop
					if (B(i)='1') then
					tmp:=tmp+2**i;
					end if;
				end loop;
				for i in 0 to 3 loop
					if ((i+tmp)<8) then
					shift(i+tmp) := A(i);
					elsif ((i+tmp>7)) then
					shift(i+tmp-8) := A(i);
					end if;
				end loop;
				   
            -- Hint: use for loop to calculate value of shift variable
            -- shift(____ downto _____) & shift(____ downto ______)
            -- to calculate exponent, you can use double asterisk. ex: 2**i

        return shift;
    end rolf;
                
begin
alu : process( A, B, sel )
begin
   if sel(0)='0' and sel(1)='0' then
      op <= rolf(A,B);
	elsif sel(0)='1' and sel(1)='0' then
      op <= sub(A,B);
	elsif sel(0)='0' and sel(1)='1' then
	   op <= ("0000") & (A nor B);
	elsif sel(0)= '1' and sel(1)= '1' then
	   op <= rolf(A,"0010");
	end if;
   -- complete VHDL code for various outputs of ALU based on select lines
   -- Hint: use if/else statement
   --
   -- sub function usage :
   --   signal_name <= sub(A,B)
   --   variable_name := sub(A,B)
   --
   -- concatenate operator usage:
   --    "0000"&A 
end process ; --alu
end a1 ; -- a1
