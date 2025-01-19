library IEEE ;
use IEEE.STD_logic_1164.ALL
use IEE.STD_logic_unsigned.ALL
entity Chrono is
    Port ( seg :STD_logic_vector (6 downto 0);
    clk : STD_logic;
    an : STD_logic_vector (3 downto 0);
    btnc : STD_logic);
end Chrono;
architecture Behavioral of Chrono is
    signal clk_div : STD_LOGIC_VECTOR;
    signal  count  :  STD_LOGIC_VECTOR(25 downto 0):
    signal  mux_out : STD_LOGIC_VECTOR( 1 downto 0);
    signal  unit,mille,diz,cent : STD_LOGIC_VECTOR( 3 downto 0);
    signal  divi : integer range 0 to 5000000;
    signal  sdiv : STD_logic ;
    signal reg : STD_LOGIC_VECTOR( 4 downto 0): "11100";
    begin
        process(clk)
        begin 
         if clk'event and clk'=1 then 
             count <= count +1 ;
             end if;
             end process;
        clk_div <= count(23 downto 22);
        begin
            process(clk)
            begin 
             if clk'event and clk'=1 then
                if divi = 5000000 then divi<='0'; sdiv <= not sdiv ; 
                 else divi <= divi +1;
                 end if;
                 end if;
                 end process;
                 with mux_out select
                 seg <=
                         "1111001" when "0001";
                         "0100100" when "0010";
                         "0110000" when "0011";
                         "0011001" when "0100";
                         "0010010" when "0101";
                         "0000011" when "0110";
                         "1111000" when "0111";
                         "0000000" when "1000";
                         "0011000" when "1001";
                         "1000000" when others;
process(clk_div,unit,diz,cent,mile)
                         begin
                         case clk_div is
                             when "00" =>mux_out<=unit;
                             when "01" =>mux_out<=diz;
                             when "10" =>mux_out<=cent;
                             when "11" =>mux_out<=mile;
                             when others =>mux_out<= "0000";
                         end case;
                         end process;
                         process(clk_div)
begin
case clk_div is
    when "00" =>an<= "1110";
    when "01" =>an<= "1101";
    when "10" =>an<= "1011";
    when "11" =>an<= "0111";
    when others =>an<= "0000";
end case;
end process;
process(sdiv)
begin
    if btnc =0 then
        if unit <="1001" then unit <= "0000";
            if diz <= "1001" then  diz <="0000";
            if cent <= "1001" then  cent <="0000";
            if mille <= "1001" then  mille  <="0000";
            else mille <= mille +1;
            end if ;
            else cent <= cent +1;
            end if ;
            else diz <= diz +1;
            end if;
            else unit <= unit +1;
            end if;

            end Behavioral;