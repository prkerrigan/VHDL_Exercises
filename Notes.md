% The Designers Guide to VHDL exercises
% Author: Patrick Kerrigan
% August 2024
## Chapter 1 - Fundamental Concepts
1. Briefly outline the purpose of the following VHDL modeling constructs:
    1. Entity declaration - outlines the input and output data ports of a given entity as well as its name
    2. Behavioral architecture body - describes the function of an entity, how to transform inputs to outputs in terms of explicit *process statements*
    3. Structural architecture body - describes the function of an entity by composing many smaller entities and connecting them with *signals*
    4. Process statements - describe how to transform data in an imperative style as a sequence of actions to be taken
    5. Signal assignment statements - declare internal signals of an architecture, physical wire or bus of wires within a structure
    6. Port map - specifies how to connect component ports to internal signals and structure ports
2. The following process statement includes a line to assign a value to test signal. Modify the process to make the assignment ineffective.
```VHDL
apply_transform : process is
begin
	d_out <= transform(d_in) after 200 ps;
	-- debug_test <= transform(d_in);
	wait on enable, d_in;
end process apply_transform;
```
3. Identify the following as valid basic identifiers, reserved words, or explain why they are invalid identifiers

|       Sample       |     Answer         |
|--------------------|--------------------|
|    last_item       |      valid         |
|    prev item	  	  |   contains space   |
|    value-1         |      valid         |
|    buffer          |     reserved       |
|    element#1       |  contains #        |
|    _control        |must start w/ alpha |
|    93_999          |must start w/ alpha |
|    entry_          |may not end w/ _    |

4. Rewrite decimal literals and hexadecimal literals

| Decimal | Hexadecimal |
|---------|-------------|
| 1       | 16#1#       |
| 34      | 16#22#      |
| 256.0   | 16#100.0#   |
| 0.5     | 16#0.8#     |

5. Rewrite the various literals as decimal literals

| Literal | Decimal  |
|---------|----------|
| 8#14#   | 12       |
| 2#1000_0100# | 262 |
| 16#2C#  | 44       |
| 2.5E5   | 250_000  |
| 2#1#E15 | 32_768   |
| 2#0.101#| 0.625    |

6. What is the difference between the literals **16#23DF#** and **X"23DF"**? First is numeric value only and the other is a bit string literal
7. Express the octal and hexadecimal bit-strings as binary bit-string literals

| X or O bit-string | binary bit-string |
|-------------------|-------------------|
| O"747"            | B"111_100_111"    |
| O"377"            | B"011_111_111"    |
| O"1_345"          | B"1_011_100_101"  |
| X"F2"             | B"1111_0010"      |
| X"0014"           | B"0000_0000_0001_0100" |
| X"0000_0001"      | B"0000_0000_0000_0000_0000_0000_0000_0001" |

8. Express the octal and hexadecimal bit-strings as binary bit-string literals or if they are illegal say why

| X or O bit-string | binary bit-string |
|-------------------|-------------------|
| 10UO"747"         | B"0_111_010_111"  |
| 10UO"377"         | B"0_011_111_111"  |
| 10UO"1_345"       | B"1_011_100_101"  |
| 10SO"747"         | B"1_111_010_111"  |
| 10SO"377"         | B"0_011_111_111"  |
| 10SO"1_345"       | truncated 00 don't match initial 1_... |
| 12UX"F2"          | B"0000_1111_0010" |
| 12SX"F2"          | B"1111_1111_0010" |
| 10UX"F2"          | B"00_1111_0010"   |
| 10SX"F2"			 | B"11_1111_0010"   |

9. Express the decimal bit strings as binary bit-string literals or if illegal explain why

| decimal literal | binary bit-string |
|-----------------|-------------------|
| D"24"           | B"11_000"         |
| 12D"24"         | B"0000_0001_1000" |
| 4D"24"          | truncated non-zero digit |

10. Write an entity declaration and behavioral architecture for a two input multiplexer. Write a text bench to test the multiplexer.
```VHDL
entity mux2 is
    port ( a, b, sel : in bit;
        z : out bit);
end entity mux2;

architecture behav of mux2 is
begin
    selector : process is
    begin
        if sel then
            z <= b;
        else
            z <= a;
        end if;
        wait for 1 ns;
    end process selector;
end architecture behav;
-- test
entity test_bench is
end entity test_bench;

architecture test_mux2 of test_bench is
    signal a, b, sel, z : bit;
begin
    dut : entity work.mux2(behav)
    port map (a, b, sel, z);
    stimulus : process is
    begin
        a <= '1'; b <= '0';
        sel <= '0'; wait for 20 ns;
        sel <= '1'; wait for 20 ns;
        a <= '0'; b <= '1';
        sel <= '0'; wait for 20 ns;
        sel <= '1'; wait for 20 ns;
        wait;
    end process stimulus;
end architecture test_mux2;
```
11. Write an entity declaration and structural architecture for a 4-bit mux composed of 4 instances of 2-bit mux's from the last question. Write a test bench for this.
```VHDL
entity mux2x4 is
    port ( a0, a1, a2, a3, b0, b1, b2, b3, sel : in bit;
        z0, z1, z2, z3 : out bit);
end entity mux2x4;

architecture struct of mux2x4 is
begin
    bit0 : entity work.mux2(behav) port map (a0, b0, sel, z0);
    bit1 : entity work.mux2(behav) port map (a1, b1, sel, z1);
    bit2 : entity work.mux2(behav) port map (a2, b2, sel, z2);
    bit3 : entity work.mux2(behav) port map (a3, b3, sel, z3);
end architecture struct;
-- test
architecture test_mux2x4 of test_bench is
    signal a0, a1, a2, a3, b0, b1, b2, b3, sel, z0, z1, z2, z3 : bit;
begin
    dut : entity work.mux2x4(struct)
    port map (a0, a1, a2, a3, b0, b1, b2, b3, sel, z0, z1, z2, z3);
    stimulus : process is
    begin
        a0 <= '1'; a1 <= '0'; a2 <= '1'; a3 <= '1';

        b0 <= '0'; b1 <= '1'; b2 <= '1'; b3 <= '0';
        sel <= '0'; wait for 20 ns;
        sel <= '1'; wait for 20 ns;
        a0 <= '0'; a1 <= '0'; a2 <= '0'; a3 <= '0';
        b0 <= '1'; b1 <= '1'; b2 <= '1'; b3 <= '1';
        sel <= '0'; wait for 20 ns;
        sel <= '1'; wait for 20 ns;
        wait;
    end process stimulus;
end architecture test_mux2x4;
```

## Chapter 2 - Scalar Data Types and Operations
1. Write a constant declaration for the number of bits in a 32-bit word and for the number $\pi ~= 3.14159$
```VHDL
constant number_of_bits : integer := 32;
constant pi : real := 3.14159;
```
2. Write variable declarations for a counter, initialized to zero; a status flag used to indicated weather a module is busy; and a standard logic-value used to store a temporary result.
```VHDL
variable counter : natural;
variable busy : boolean;
variable temp : std_ulogic;
```
3. Given the declarations from 2, write variable assignment statements to increment the counter, to set the status flag to indicate the module is busy and to indicated a weak unknown temporary result.
```VHDL
counter := natural'succ(counter);
busy := true;
temp := 'W';
```
4. Write a package declaration containing type declarations for small non-negative integers represent-able in eight bits; fractional numbers between -1.0 and +1.0; electrical currents, with units of $nA$, $\mu A$, $mA$, $A$; and traffic light colors.
```VHDL
package problem_types is
	type uint8 is range 0 to 255;
	type factor is range -1.0 to 1.0;
	type current is range 0 to 1E12
		units
			nA;
			uA = 1_000 nA;
			mA = 1_000 uA;
			A  = 1_000 mA;
		end units current;
	type traffic_light_colors is (off, red, yellow, green);
end package problem_types;
``` 
5. Given the following declarations:
```VHDL
signal a, b, c : std_ulogic;
type state_type is (idle, req, ack);
signal state : state_type;
```
indicate whether each of the following expressions is legal as a Boolean condition, and if not, correct it:

| expression         | is legal? / correction |
|--------------------|------------------------|
| a **and not** b **and** c |  legal          |
| a **and not** b **and** state = idle | a **and not** b **and** std_ulogic(state = idle) |
| a = '1' **and not** b **and** state = idle | a = '1' **and not** boolean(b) **and** state = idle |
| a = '1' **and not** b = '0' **and** state = idle | legal |

6. Given the subtype declarations
```VHDL
subtype pulse_range is time range 1 ms to 100 ms;
subtype word_index is integer range 31 downto 0;
```
what are the values of 'left, 'right, 'low, 'high and 'ascending attributes of each of these subtypes?

| attribute | value |
|-----------|-------|
| pulse_range'left | 1 ms |
| pulse_range'right | 100 ms |
| pulse_range'low | 1 ms |
| pulse_range'high | 100 ms |
| pulse_range'ascending | true |
| word_index'left | 31 |
| word_index'right | 0 |
| word_index'low | 0 |
| word_index'high | 31 |
| word_index'ascending | false |

7. Given the type declaration
```VHDL
type state is (off, standby, active1, active2);
```

find the values of the expressions:

| expression | value |
|------------|-------|
| state'pos(standby) | 1 |
| state'val(2) | active1 |
| state'succ(active2) | ***error*** |
| state'pred(active1) | standby |
| state'leftof(off) | ***error*** |
| state'rightof(off) | standby |

8. For each of the following expressions, indicate whether they are syntactically correct, and if so, determine the resulting value.

| expression | value |
|------------|-------|
| 2 * 3 + 6 / 4 | 7 |
| 3 + -4 | -1 |
| "cat" & character'('0') | "cat0" |
| true **and** x **and not** y **or** z | x **and not** y **or** z |
| B"101110" **sll** 3 | B"110000" |
| (B"100010" **sra** 2) & X"2C" | B"001000_0010_1100" |

9. Write a counter model with a clock input *clk* of type *bit*, and an output *q* of type *integer*. The behavioral architecture should contain a process that declares a count variable initialized to zero. The process should wait for changes on *clk*. When *clk* changes to '1', the process should increment the count and assign its value to the output port.

```VHDL
entity counter is
    port (clk : in bit;
        count : out integer := 0);
end entity counter;

architecture behav of counter is
begin
    counting : process is
        variable internal_count : NATURAL;
    begin
        if RISING_EDGE(clk) then
            internal_count := NATURAL'succ(internal_count);
        end if;
        count <= internal_count;
        wait on clk;
    end process counting;
end architecture;	
```

10. Write a model that represents a simple ALU with *integer* inputs and output, and a function select input of type *bit*. If the function selection is 0 the ALU should output the sum of inputs, and if the function selection is 1, it should be the difference of inputs.
```VHDL
entity ALU is
    port (a, b : in INTEGER;
        op : in BIT;
        z : out INTEGER);
end entity ALU;

architecture behav of ALU is
begin
    operate : process is
        variable result : INTEGER;
    begin
        if op then
            result := a - b;
        else
            result := a + b;
        end if;
        z <= result;
    end process operate;
end architecture;
```

11. Write a model for a digital integrator that has a clock input of type **bit** and data input and output of type **real**. The integrator maintains the sum of successive data input values. When the clock input changes from zero to one, the integrator should add the current data input to the sum and provide the new sum as output.

```VHDL
entity integrator is
    port (data      : in REAL;
          clk       : in BIT;
          integral  : out REAL);
end entity integrator;

architecture behav of integrator is
begin
    integrate : process is
        variable sum : REAL;
    begin
        if RISING_EDGE(clk) then
            sum := sum + data;
        end if;
        integral <= sum;
        wait on clk;
    end process integrate;
end architecture;
```

12. Following is a process that generates a regular clock signal.
```VHDL
clock_gen : process is
begin
	clk <= '1'; wait for 10 ns;
	clk <= '0'; wait for 10 ns;
end process clock_gen;
```

use this as a basis for experiments to determine how your simulator behaves with different settings for the resolution limit. Try setting the resolution limit to $1\hspace{1mm} ns$ (default for many), $1\hspace{1mm} ps$, and $1\hspace{1mm} \mu s$.

13. Write a model for a tristate buffer using the standard-logic type for its data and enable inputs and data output. If the enable input is '0' or 'L', the output should be 'Z'. If enable is '1' or 'H' and the data input is '0' or 'L', the output should be '0', while if data is '1' of 'H', the output should be '1'. In all other cases, the output should be 'X'.
```VHDL
library ieee;
use ieee.std_logic_1164.all;

entity tristate_buffer is
    port (en , din    : in  STD_ULOGIC;
        dout          : out STD_ULOGIC := 'X');
end entity tristate_buffer;

architecture behav of tristate_buffer is

begin

    fix : process is
        variable state : STD_ULOGIC := 'X';
    begin
        if en ?= '0' then
            state := 'Z';
        elsif en ?= '1' then
            
            if din ?= '0' then
                state := '0';
            elsif din ?= '1' then
                state := '1';
            else
                state := 'X';
            end if;
            
        else
            state := 'X';
        end if;
        dout <= state;
        wait for 1 ns;
    end process fix;

end architecture;
```
quick test bench
```VHDL
library ieee;
use ieee.std_logic_1164.all;

architecture test_tristate of test_bench is
    signal en, din, dout : STD_ULOGIC;
begin
    dut : entity work.tristate_buffer(behav)
    port map (en, din, dout);
    stimulus : process is
    begin
        wait for 5 ns;
        en <= '0';
        wait for 5 ns;
        en <= 'L';
        wait for 5 ns;
        en <= '1'; din <= '0';
        wait for 5 ns;
        din <= 'L';
        wait for 5 ns;
        din <= '1';
        wait for 5 ns;
        din <= 'H';
        wait for 5 ns;
        din <= 'W';
        wait for 5 ns;
        din <= 'X';
        wait for 5 ns;
        en <= 'X';
        wait;
    end process stimulus;
end architecture test_tristate;
```

## Chapter 3 - Sequential Statements
1. Write and if statement that sets a variable **odd** to '1' if an integer **n** is odd, or to '0' if it is even. Also write this as a conditional variable assignment.
```VHDL
if n mod 2 = 1 then
	odd <= '1';
else
	odd <= '0';
end if;
-- conditional assignment
odd := '1' when n mod 2 = 1
	else '0';
```

2. Write an if statement, given the year of today's date in the variable **year** set the variable days_in_February to the number of days in February. A year is a leap year if it is divisible by four, except for years divisible by 100. However, years that are divisible by 400 are leap years. February has 29 days in a leap year and 28 days otherwise. Also write this as a conditional variable assignment.
```VHDL
if (year rem 4 = 0 and not year rem 100 = 0) or year rem 400 = 0 then
	days_in_February <= 29;
else
	days_in_February <= 28;
end if;
-- conditional assignment
days_in_February := 29 when (year rem 4 = 0 and not year rem 100 = 0) or year rem 400 = 0
	else 28;
```

3. Write a case statement that strips the strength information from a standard-logic variable **x**. If **x** is '0' or 'L', set it to '0'. If **x** is '1' or 'H', set it to '1'. If **x** is 'X', 'W', 'Z', 'U', or '-', set it to 'X'. (This is to conversion performed by the standard-logic function **to_X01**.) Also write as selected variable assignment.
```VHDL
case x is
	when '0' | 'L' =>
		x := '0';
	when '1' | 'H' =>
		x := '1';
	when others =>
		x := 'X';
end case;
-- selected variable assignment
with x select
	x := '0' when '0' | 'L',
		 '1' when '1' | 'H',
		 'X' when others;
```

4. Write a case statement that sets an integer variable **character_class** to 1 if the character variable **ch** contains a letter, to 2 if it contains a digit, to 3 if it contains some other printable character or to 4 if it contains a non-printable character. Also write this as a selected variable assignment.
```VHDL
case ch is
	when 'A' to 'Z' | 'a' to 'z' =>
		character_class := 1;
	when '0' to '9' =>
		character_class := 2;
	when nul to usp | del =>
		character_class := 4;
	when others =>
		character_class := 3;
-- selected variable assignment
with ch select
	character_class :=
		1 when 'A' to 'Z' | 'a' to 'z',
		2 when '0' to '9',
		4 when nul to usp | del,
		3 when others;
```

5. Write a loop statement that samples a bit input **d** when a clock input **clk** changes to '1'. So long as **d** is '0', the loop continues executing. When **d** is '0' the loop exits.
```VHDL
loop
	sample := d when RISING_EDGE(clk);
	if sample = '1' then
		exit;
	end if;
end loop;
```

6. Write a while loop that calculates the exponential function of **x** to an accuracy of one part in 104 by summing terms of the following series: $e^x=1+x+\frac{x^2}{2!}+\frac{x^3}{3!}+\frac{x^4}{4!}+\dots$
```VHDL
ENTITY exp IS
   PORT (
      x : IN REAL;
      result : OUT REAL);
END ENTITY exp;

ARCHITECTURE series OF exp IS
BEGIN

   summation : PROCESS (x) IS
      VARIABLE sum, term : REAL;
      VARIABLE n : NATURAL;
   BEGIN
      sum := 1.0;
      term := 1.0;
      n := 0;
      WHILE ABS term > ABS (sum / 104.0) LOOP
         n := n + 1;
         term := term * x / REAL(n);
         sum := sum + term;
      END LOOP;
      result <= sum;
   END PROCESS summation;

END ARCHITECTURE series;
-- test
architecture test_exp of test_bench is 
    signal x, result : REAL := 0.0;
begin
    dut : entity work.exp(series)
    port map (x, result);
    stimulus : process is
    begin
        x <= 1.0; wait for 5 ns;
        x <= 2.0; wait for 5 ns;
        x <= 0.0; wait for 5 ns;
        x <= (-1.0); wait for 5 ns;
        x <= (-3.0); wait for 5 ns;
        x <= 10.0; wait for 5 ns;
    end process stimulus;
end architecture test_exp;
```

7. Write a for loop that calculates the exponential function of **x** by summing the first eight terms of the series in Exercise 6.
```VHDL
ARCHITECTURE bounded OF exp IS
BEGIN

   summation : PROCESS (x) IS
      VARIABLE sum, term : REAL;
   BEGIN
      sum := 1.0;
      term := 1.0;
      FOR n IN 1 TO 7 LOOP
         term := term * x / REAL(n);
         sum := sum + term;
      END LOOP;
      result <= sum;
   END PROCESS summation;

END ARCHITECTURE bounded;
-- test
architecture test_exp of test_bench is 
    signal x, result : REAL := 0.0;
begin
    dut : entity work.exp(bounded)
    port map (x, result);
    stimulus : process is
    begin
        x <= 1.0; wait for 5 ns;
        x <= 2.0; wait for 5 ns;
        x <= 0.0; wait for 5 ns;
        x <= (-1.0); wait for 5 ns;
        x <= (-3.0); wait for 5 ns;
        x <= 10.0; wait for 5 ns;
    end process stimulus;
end architecture test_exp;
```

8. Write an assertion statement that expressed the requirement that a flip flops two outputs, **q** and **q_n**, of type **std_logic**, are complementary.
```VHDL
output_complementary : assert q ?/= q_n report "Non-complementary flip flop output!" severity failure;
```
9. Add report statement to previous exercise.
10. Develop a behavioral model for a limiter with integer inputs, **data_in**, **lower**, **upper**; an integer output, **data_out**; and a bit output, **out_of_limits**. **data_out** follows **data_in** while between **lower** and **upper**. If **data_in** is less then **lower**, **data_out** is **lower**, while if **data_in** is greater then **upper**, **data_out** is **upper**. The **out_of_limit** output indicates when **data_out** is limited.
```VHDL
ENTITY limiter IS
   PORT (
      data_in, lower, upper : IN INTEGER;
      data_out : OUT INTEGER;
      out_of_limit : OUT BIT);
END ENTITY limiter;

ARCHITECTURE behav OF limiter IS
BEGIN

   limit : PROCESS (data_in, lower, upper) IS
   BEGIN
      IF data_in < lower THEN
         data_out <= lower;
         out_of_limit <= '1';
      ELSIF data_in > upper THEN
         data_out <= upper;
         out_of_limit <= '1';
      ELSE
         data_out <= data_in;
         out_of_limit <= '0';
      END IF;
   END PROCESS limit;

END ARCHITECTURE behav;

-- test
architecture test_limiter of test_bench is
    signal data_in, lower, upper, data_out : integer := 0;
    signal out_of_limit : bit := '0';
begin
    dut : entity work.limiter(behav)
    port map (data_in, lower, upper, data_out, out_of_limit);
    stimulus : process is
    begin
        data_in <= 0; lower <= (-10); upper <= 10; wait for 10 ns;
        data_in <= (-9); wait for 10 ns;
        data_in <= (-10); wait for 10 ns;
        data_in <= (-11); wait for 10 ns;
        data_in <= integer'low; wait for 10 ns;
        data_in <= 9; wait for 10 ns;
        data_in <= 10; wait for 10 ns;
        data_in <= 11; wait for 10 ns;
        data_in <= integer'high; wait for 10 ns;
        wait;
    end process stimulus;
end architecture test_limiter;
```

11. Develop a model for a floating-point arithmetic unit with data input **x** and **y**, data output **z** and function code inputs **f0** and **f1** of type *bit*. $(f0, f1) = (0,0)$ encodes addition, $(1,0)$ is subtraction of **y** from **x**, $(0,1)$ multiplication and $(1,1)$ division of **x** by **y**.
```VHDL
ENTITY floating_ALU IS
   PORT (
      x, y : IN REAL;
      f0, f1 : IN BIT;
      z : OUT REAL
   );
END ENTITY floating_ALU;

ARCHITECTURE behav OF floating_ALU IS
BEGIN

   alu : PROCESS (x, y, f0, f1) IS
      VARIABLE result : REAL;
   BEGIN

      result := x + y WHEN NOT f0 AND NOT f1
         ELSE x - y WHEN f0 AND NOT f1
         ELSE x * y WHEN NOT f0 AND f1
         ELSE x / y WHEN y /= 0.0
         ELSE REAL'HIGH; -- when y is 0.0

      z <= result;

   END PROCESS alu;

END ARCHITECTURE behav;
-- test
architecture test_floating_ALU of test_bench is
    signal x, y, z : real := 0.0;
    signal f0, f1 : bit := '0';
begin
    dut : entity work.floating_ALU(behav)
    port map (x, y, f0, f1, z);
    stimulus : process is
    begin
        x <= 3.0; y <= 3.0; wait for 10 ns;
        f0 <= '1'; wait for 10 ns;
        f1 <= '1'; wait for 10 ns;
        f0 <= '0'; wait for 10 ns;
        x <= 1.0; y <= 0.0;
        f1 <= '0'; wait for 10 ns;
        f0 <= '1'; wait for 10 ns;
        f1 <= '1'; wait for 10 ns;
        f0 <= '0'; wait for 10 ns;
        wait;
    end process stimulus;
end architecture test_floating_ALU;
```

12. Write a model for a counter with an output port of type **natural** , initially set to 15. When the **clk** input changes to '1', the counter decrements by 1. After counting down to 0, the counter wraps back to 15 on the next clock edge.
```VHDL
PACKAGE int_types IS
   TYPE count16 IS RANGE 15 DOWNTO 0;
END PACKAGE int_types;

USE work.int_types.ALL;

ENTITY count_down_16 IS
   PORT (
      clk : IN BIT;
      counter : OUT count16
   );
END ENTITY count_down_16;

ARCHITECTURE behav OF count_down_16 IS
BEGIN

   procceed : PROCESS (clk) IS
      VARIABLE count : count16 := 15;
   BEGIN

      counter <= count;
      count := count16'rightof(count) WHEN RISING_EDGE(clk) AND count /= 0
         ELSE 15 WHEN RISING_EDGE(clk);

   END PROCESS procceed;
END ARCHITECTURE behav;

-- test
use work.int_types.all;

architecture test_count of test_bench is
    signal clk : bit := '0';
    signal counter : count16 := 15;
begin
    dut : entity work.count_down_16(behav)
    port map (clk, counter);
    stimulus : process is
    begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
    end process stimulus;
end architecture test_count;

```

13. Modify the counter of 12 to include an asynchronous load input and a data input. When load input is '1', the counter is preset to the data input, and when the load input changes back to '0', the counter continues counting down from the preset value.
```VHDL
ENTITY count_down_16 IS
   PORT (
      clk, load : IN BIT;
      data : IN count16;
      counter : OUT count16
   );
END ENTITY count_down_16;

ARCHITECTURE behav OF count_down_16 IS
BEGIN

   procceed : PROCESS (clk) IS
      VARIABLE count : count16 := 15;
   BEGIN

      IF load THEN
         count := data;
      ELSE
         count := count16'rightof(count) WHEN RISING_EDGE(clk) AND count /= 0
            ELSE 15 WHEN RISING_EDGE(clk);
      END IF;
      counter <= count;

   END PROCESS procceed;
END ARCHITECTURE behav;
```

14. Develop a model of an averaging module that calculates the average of batches of 16 real numbers. The module has clock and data inputs and a data output. The module accepts the next input number when the clock changes to '1'. After 16 numbers have been accepted, the module places their average on the output port, the repeats the process for the next batch.
```VHDL
ENTITY average16 IS
    PORT (
        clk : IN BIT;
        datum : IN REAL;
        average : OUT REAL
    );
END ENTITY average16;

ARCHITECTURE behav OF average16 IS
    subtype index is integer range 16 downto 0;
BEGIN

    averaging : PROCESS (clk) IS
        VARIABLE sum : REAL := 0.0;
        VARIABLE count : index;
    BEGIN

        IF count = 0 THEN
            average <= sum / 16.0;
            sum := 0.0;
            count := 16;
        END IF;

        IF RISING_EDGE(clk) THEN
            sum := sum + datum;
            count := index'rightof(count);
        END IF;

    END PROCESS averaging;
END ARCHITECTURE behav;

--test
architecture test_average of test_bench is
    signal clk : BIT := '0';
    signal datum, average : REAL := 0.0;
begin
    
    dut : entity work.average16(behav)
    port map (clk, datum, average);
    stimulus : process is
        variable datum_l : REAL;
    begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
        datum_l := datum + 1.0;
        datum <= datum_l;
        
    end process stimulus;
end architecture test_average;
```

15. Write a model that causes assertion violations with different severity levels. Experiment with your simulator to see what happens when an assertion violation occurs. See if you can specify a severity level above which it stops executing.
```VHDL
architecture test_clk_errors of test_bench is
    signal clk : bit;
begin

    clock_gen : process is
    begin
        clk <= '1'; wait for 10 ns;
        clk <= '0'; wait for 10 ns;
        assert FALSE report "NOTE" severity NOTE;
        clk <= '1'; wait for 10 ns;
        clk <= '0'; wait for 10 ns;
        assert FALSE report "WARNING" severity WARNING;
        clk <= '1'; wait for 10 ns;
        clk <= '0'; wait for 10 ns;
        assert FALSE report "ERROR" severity ERROR;
        clk <= '1'; wait for 10 ns;
        clk <= '0'; wait for 10 ns;
        assert FALSE report "FAILURE" severity FAILURE;
			-- simulation ends on failure.
        clk <= '1'; wait for 10 ns;
        clk <= '0'; wait for 10 ns;
    end process clock_gen;

end architecture;
```

## Chapter 4 - Composite Data Types and Operations
1. Write an array type declaration for an array of 30 integers, and a variable declaration for a variable of this type. Write a for loop to calculate the average of the array elements.
```VHDL
ENTITY average_30 IS
   PORT (
      samples : IN INTEGER_VECTOR(1 TO 30);
      average : OUT REAL
   );
END ENTITY average_30;

ARCHITECTURE behavioral OF average_30 IS

BEGIN

   compute : PROCESS (samples) IS
      VARIABLE sum : INTEGER;
   BEGIN
      sum := 0;
      FOR i IN samples'RANGE LOOP
         sum := sum + samples(i);
      END LOOP;
      average <= REAL(sum) / 30.0;
   END PROCESS compute;

END ARCHITECTURE;
-- test
architecture test_average_30 of test_bench4 is
    signal samples : INTEGER_VECTOR(1 to 30) := (others => 0);
    signal average : REAL := 0.0;
begin

    dut : entity work.average_30(behavioral)
    port map (samples, average);
    
    stimulus : process is
    begin
        samples <= (1, others => 0); wait for 10 ns;
        samples <= (1, 1, 1, others => 0); wait for 10 ns;
        samples <= (others => 1); wait for 10 ns;
        samples <= (15 to 29 => 2, others => (-1)); wait for 10 ns;
    end process stimulus;

end architecture;
```

2. Write an array type declaration for an array of bit values, indexed by standard logic values. Then write a declaration for a constant, **std_ulogic_to_bit**, of this type that maps standard logic values to the corresponding bit value, assuming unknown values map to '0'. Given a standard-logic vector **v1** and a bit-vector variable **v2**, both indexed from 0 to 15, write a for loop that uses the constant **std_ulogic_to_bit** to map the standard-logic vector to a bit vector.
```VHDL
library ieee;
use ieee.std_logic_1164.all;

entity vector_std_ulogic_to_bit is
    port (
        v1 : in std_ulogic_vector;
        v2 : out bit_vector
    );
end entity vector_std_ulogic_to_bit;

architecture behav of vector_std_ulogic_to_bit is
    type std_ulogic_to_bit_type is array (std_ulogic) of bit;
begin
    
    mapping : process (v1) is
        constant std_ulogic_to_bit : std_ulogic_to_bit_type := (
            '1' | 'H' => '1',
            others => '0'
        );
        variable v : bit_vector(v1'range);
    begin
        for i in v1'range loop
            v(i) := std_ulogic_to_bit(v1(i));
        end loop;
        v2 <= v;
    end process mapping;
    
end architecture behav;

-- test
library ieee;
use ieee.std_logic_1164.all;

architecture test_vector_std_ulogic_to_bit of test_bench4 is
    signal v1 : std_ulogic_vector(0 to 15) := (others => '-');
    signal v2 : bit_vector(0 to 15) := (others => '0');
begin
    
    dut : entity work.vector_std_ulogic_to_bit(behav)
    port map (v1, v2);
    
    stimulus : process is
    begin
        v1 <= ('U', '0', '1', 'L', 'H', 'X', 'W', 'Z', others => '-');
        wait for 10 ns;
        v1 <= (others => 'X');
        wait for 10 ns;
        v1 <= (others => 'H');
        wait for 10 ns;
    end process stimulus;
    
end architecture;
```

3. The data on a diskette is arranged in 18 sectors per track, 80 tracks per side, and 2 sides per disk. A computer system maintains a map of free sectors. Write a 3D array type declaration to represent such a map, with '1' element representing a free sector and '0' to an occupied sector. Write a set of nested loops to scan a variable of this type for the first free sector location.
```VHDL
package diskette is
    constant sector_length : POSITIVE := 18;
    constant track_length : POSITIVE := 80;
    constant side_number : POSITIVE := 2;
    
    type index is record
        sector : NATURAL range 0 to sector_length;
        track : NATURAL range 0 to track_length;
        sides : NATURAL range 0 to side_number;
    end record index;
    
    type occupied is array (
            1 to sector_length,
            1 to track_length,
            1 to side_number
        ) of bit;
        
end package diskette;

use work.diskette.all;
entity sector_tracker is
    port (
        state : in occupied;
        ix : out index
    );
end entity sector_tracker;

architecture behav of sector_tracker is
begin
    
    search : process (state) is
        -- for the first free sector and assign its location to ix
        variable temp : index;
    begin
        temp := (0, 0, 0);
        outer : for si in state'range(1) loop
            for tr in state'range(2) loop
                for sect in state'range(3) loop
                    if state(si, tr, sect) then
                        temp := (si, tr, sect);
                        exit outer;
                    end if;
                end loop;
            end loop;
        end loop;
        ix <= temp;
        
    end process search;
    
end architecture behav;

-- testbench
use work.diskette.all;

architecture test_diskette of test_bench4 is
    signal state : occupied := (others => (others => (others => '0')));
    signal ix : index := (others => 0);
    signal sector, track, sides : NATURAL;
begin
    
    dut : entity work.sector_tracker(behav)
    port map (state, ix);
    
    stimulus : process is
    begin
        state <= (others => (others => (others => '0')));
        wait for 1 ns;
        sector <= ix.sector;
        track <= ix.track;
        sides <= ix.sides;
        wait for 4 ns;
        
        state <= (
            9 => (
                40 => (
                    1 => '1',
                    others => '0'
                ),
                others => (others => '0')
            ),
            others => (others => (others => '0')));
        wait for 1 ns;
        sector <= ix.sector;
        track <= ix.track;
        sides <= ix.sides;
        wait for 4 ns;
        
        state <= (
            1 to 10 => (
                3 to 40 => (
                    1 => '1',
                    others => '0'),
                others => (others => '0')
            ),
            others => (others => (others => '0')));
        wait for 1 ns;
        sector <= ix.sector;
        track <= ix.track;
        sides <= ix.sides;
        wait for 4 ns;
        
    end process stimulus;
    
end architecture;

```

4. Write a declaration for a subtype of **std_ulogic_vector**, representing a byte. Declare a constant of this subtype with each element having value 'Z'
```VHDL
subtype byte is std_ulogic_vector(1 to 8);

constant all_high : byte := "ZZZZZZZZ";
```
5. Write a type declaration for an unconstrained array of **time_vector** elements, indexed by **positive** values. Then write a subtype declaration representing an array with 4 unconstrained elements. Last write a variable declaration using the subtype with each element having 10 subelements.

```VHDL
type time_samples is array (positive range <>) of time_vector;
subtype four_samples is time_samples(1 to 4);
subtype ten_times is four_samples(open)(1 to 10);
```

6. Write a for loop to count the number of '1' elements in a bit-vector variable *v*.
```VHDL
entity trace is
    port(
        v : in bit_vector;
        sum : out natural
    );
end entity trace;

architecture behav of trace is

begin

    summing : process (v) is
        variable accum : natural;
    begin
        accum := 0;
        for i in v'range loop
            accum := accum + 1 when v(i);
        end loop;
        sum <= accum;
    end process summing;

end architecture;

--test bench

architecture test_trace of test_bench4 is
    signal source : bit_vector(1 to 10);
    signal sum : natural;
begin
    
    dut : entity work.trace(behav)
    port map (source, sum);
    
    stimulus : process is
    begin
        source <= (others => '1');
        wait for 5 ns;
        source <= ('1', others => '0');
        wait for 5 ns;
        source <= ('1', '1', '1', others => '0');
        wait for 5 ns;
    end process stimulus;
    
end architecture;
```

7. An 8-bit vector *v1* representing a two's complement binary integer can be signal extended into a 32-bit vector *v2* by copying it to the leftmost 8 positions of *v2*, then performing an arithmetic shift right to move the 8 bits to the rightmost eight positions. Write variable assignment statements that use slicing and shift operation to express this procedure.
```VHDL
entity repack8to32a is
    port (
        v1 : in bit_vector(0 to 7);
        v2 : out bit_vector(0 to 31)
    );
end entity repack8to32a;

architecture cycle of repack8to32a is
begin
    place_and_shift : process (v1) is
        variable v : bit_vector(0 to 31);
    begin
    -- Initialize v with all zeros
        v := (others => '0');

    -- Assign v1 to the upper part of v
        for i in v1'range loop
            v(i+24) := v1(i);
        end loop;

    -- Perform arithmetic fill left by 24 bits
        v(0 to 24) := (others => v1(0));

        v2 <= v;
    end process place_and_shift;
end architecture cycle;

--testbench
architecture repack8to32a of test_bench4 is
    signal v1 : BIT_VECTOR(0 to 7);
    signal v2 : BIT_VECTOR(0 to 31);

begin

    dut : entity work.repack8to32a(cycle)
    port map (v1, v2);
    
    stimulus : process is
    begin
        v1 <= (others => '1'); wait for 5 ns;
        v1 <= ('0', others => '1'); wait for 5 ns;
        v1 <= (others => '0'); wait for 5 ns;
        v1 <= ('1', '1', '1', others => '0'); wait for 5 ns;
    end process stimulus;

end architecture;
```

8. Write a record type declaration for a stimulus record containing a stimulus bit vector of 3 bits, a delay value, and an expected response bit vector of 8 bits
```VHDL
PACKAGE test_records IS
    TYPE test1 IS RECORD
        sample_input : bit_vector(0 TO 2);
        delay : TIME;
        expected_output : bit_vector(0 TO 7);
    END RECORD test1;
END PACKAGE test_records;
```

9. Develop a model for a register that stores 16 words of 32 bits each. The register file has a data input and output ports, each an **integer** in the range 0 to 15; and a write-enable port of type **bit**. Data out is the contents of the word at the read-address. When the write-enable is '1', the input data is written to the register word at the write-address. 
```VHDL
PACKAGE dtypes IS
    SUBTYPE word IS bit_vector(0 TO 31);
    CONSTANT default_word : word := (others => '0');
    SUBTYPE address IS INTEGER RANGE 0 TO 15;
    TYPE the_file IS ARRAY (address) OF word;
END PACKAGE dtypes;

USE work.dtypes.ALL;

ENTITY register_file IS
    PORT (
        din : IN word;
        w_adr : IN address;
        r_adr : IN address;
        w_en : IN BIT;
        dout : OUT word
    );
END ENTITY register_file;

ARCHITECTURE behav OF register_file IS
BEGIN

    read_write : PROCESS (ALL) IS
        VARIABLE state : the_file := (OTHERS => default_word);
    BEGIN

        IF w_en THEN
            state(w_adr) := din;
        END IF;

        dout <= state(r_adr);

    END PROCESS read_write;

END ARCHITECTURE;
-- test
ENTITY test_register IS
END ENTITY test_register;

USE work.dtypes.ALL;

ARCHITECTURE test OF test_register IS
    SIGNAL din, dout : word;
    SIGNAL w_adr, r_adr : address;
    SIGNAL w_en : BIT;
BEGIN

    dut : ENTITY work.register_file(behav)
        PORT MAP(din, w_adr, r_adr, w_en, dout);

    stimulus : PROCESS IS
    BEGIN

        din <= ('1', '1', others => '0');
        w_adr <= 6;
        r_adr <= 1;
        w_en <= '1';
        WAIT FOR 5 ns;

        din <= ('0', '1', '1', others => '0');
        w_adr <= 1;
        r_adr <= 6;
        WAIT FOR 5 ns;

        din <= (others => '1');
        w_en <= '0';
        r_adr <= 1;
        WAIT FOR 5 ns;

        w_adr <= 15;
        r_adr <= 15;
        WAIT FOR 5 ns;
        
        w_en <= '1';
        wait for 5 ns;
        
        r_adr <= 2;
        wait for 5 ns;

    END PROCESS stimulus;

END ARCHITECTURE;
```

10. Develop a model for a priority encoder with a 16-element bit-vector input port, an output port of type **natural** that encodes the index of the leftmost '1' value in the input port and an output of type **bit** that indicates whether any of the input components are '1'.
```VHDL
ENTITY encoder IS
    PORT (
        bytes : IN bit_vector(0 TO 15);
        first : OUT NATURAL RANGE 0 TO 15;
        any : OUT BIT
    );
END ENTITY encoder;

ARCHITECTURE behav OF encoder IS

BEGIN

    search : PROCESS (bytes) IS
        VARIABLE buf : BIT;
    BEGIN

        buf := OR bytes;

        IF buf THEN
            FOR i IN bytes'RANGE LOOP
                IF bytes(i) THEN
                    first <= i;
                    EXIT;
                END IF;
            END LOOP;
        END IF;

        any <= buf;

    END PROCESS search;

END ARCHITECTURE;

--test
ENTITY test_encoder IS
END ENTITY test_encoder;

ARCHITECTURE test OF test_encoder IS
    SIGNAL bytes : bit_vector(0 TO 15);
    SIGNAL first : NATURAL RANGE 0 TO 15;
    SIGNAL any : BIT;
BEGIN

    dut : ENTITY work.encoder(behav)
        PORT MAP(bytes, first, any);

    stimulus : PROCESS IS
    BEGIN

        bytes <= (OTHERS => '0');
        WAIT FOR 5 ns;
        bytes <= ('1', OTHERS => '0');
        WAIT FOR 5 ns;
        bytes <= ('0', OTHERS => '1');
        WAIT FOR 5 ns;
        bytes <= (14 => '1', OTHERS => '0');
        WAIT FOR 5 ns;

    END PROCESS stimulus;

END ARCHITECTURE;
```

11. Write a module to find the maximum value from an unconstrained array of integers. Make sure if works correctly for even null length vectors.

```VHDL
ENTITY maximum IS
    PORT (
        sample : IN integer_vector;
        max : OUT INTEGER
    );
END ENTITY maximum;

ARCHITECTURE behav OF maximum IS
BEGIN

    find : PROCESS (sample) IS
        VARIABLE partial_max : INTEGER;
    BEGIN

        partial_max := INTEGER'low;

        FOR i IN sample'RANGE LOOP
            IF sample(i) > partial_max THEN
                partial_max := sample(i);
            END IF;
        END LOOP;
        
        max <= partial_max;

    END PROCESS find;

END ARCHITECTURE;

--test
ENTITY test_maximum IS
END ENTITY test_maximum;

ARCHITECTURE test OF test_maximum IS
    SIGNAL sample0 : integer_vector(1 TO 0);
    SIGNAL sample15 : integer_vector(0 TO 15);
    SIGNAL null_max : INTEGER;
    SIGNAL max : INTEGER;
BEGIN

    null_dut : ENTITY work.maximum(behav)
        PORT MAP(sample0, null_max);

    dut : ENTITY work.maximum(behav)
        PORT MAP(sample15, max);

    stimulus : PROCESS IS
    BEGIN

        sample15 <= (0, 0, 0, OTHERS => 1);
        WAIT FOR 5 ns;

        sample15 <= (31, 20, OTHERS => 0);
        WAIT FOR 5 ns;

        sample15 <= (3, 1, 21, 15, 40, 1, (-1), 12, OTHERS => 0);
        WAIT FOR 5 ns;

        sample15 <= ((-1), OTHERS => (-2));
        WAIT FOR 5 ns;

    END PROCESS stimulus;

END ARCHITECTURE;
```

12. Develop a model for a general and-or-invert gate, with two **std_logic_vector** input ports *a, b*, and a **std_logic** output port *y*.

```VHDL
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY and_or_invert IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR;
        y : OUT STD_LOGIC
    );
END ENTITY and_or_invert;

ARCHITECTURE behav OF and_or_invert IS

BEGIN

    aoi : PROCESS (a, b) IS
    BEGIN

        y <= NOT ( OR (a AND b));

    END PROCESS aoi;

END ARCHITECTURE;

--test
ENTITY test_and_or_invert IS
END ENTITY;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ARCHITECTURE test OF test_and_or_invert IS
    SIGNAL a, b : STD_LOGIC_VECTOR(0 TO 3);
    SIGNAL y : STD_LOGIC;
BEGIN

    dut : ENTITY work.and_or_invert(behav)
        PORT MAP(a, b, y);

    stimulus : PROCESS IS
    BEGIN

        a <= ('1', '1', '0', '0');
        b <= ('0', '0', '1', '1');
        WAIT FOR 5 ns;

        b <= ('1', OTHERS => '0');
        WAIT FOR 5 ns;

        a <= (OTHERS => '1');
        WAIT FOR 5 ns;

        b <= (OTHERS => '1');
        WAIT FOR 5 ns;

        a <= (OTHERS => '0');
        WAIT FOR 5 ns;

    END PROCESS stimulus;

END ARCHITECTURE;
```

13. Develop a model of a 3 to 8 encoder and test bench to exercise the decoder. In the test bench, declare the record type written in exercise 8 and a constant array of test record values. Initialize the array to a set of test vectors for the decoder, and the them to perform the test.

```VHDL
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY decoder IS
    PORT (
        code : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        selection : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE behav OF decoder IS
BEGIN

    decode : PROCESS (code) IS
        VARIABLE index : INTEGER RANGE 7 DOWNTO 0;
    BEGIN

        selection <= (OTHERS => '0');

        index := to_integer(unsigned(code));

        selection(index) <= '1';

    END PROCESS decode;

END ARCHITECTURE;

---test
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE tests IS

    TYPE three_to_eight IS RECORD
        sample_input : STD_LOGIC_VECTOR(2 DOWNTO 0);
        delay : TIME;
        expected_output : STD_LOGIC_VECTOR(7 DOWNTO 0);
    END RECORD three_to_eight;

    TYPE sample IS ARRAY (NATURAL RANGE <>) OF three_to_eight;

    CONSTANT expected : sample := (
        (sample_input => B"000", delay => 5 ns, expected_output => B"0000_0001"),
        (sample_input => B"001", delay => 5 ns, expected_output => B"0000_0010"),
        (sample_input => B"010", delay => 5 ns, expected_output => B"0000_0100"),
        (sample_input => B"011", delay => 5 ns, expected_output => B"0000_1000"),
        (sample_input => B"100", delay => 5 ns, expected_output => B"0001_0000"),
        (sample_input => B"101", delay => 5 ns, expected_output => B"0010_0000"),
        (sample_input => B"110", delay => 5 ns, expected_output => B"0100_0000"),
        (sample_input => B"111", delay => 5 ns, expected_output => B"1000_0000")
    );

END PACKAGE tests;

ENTITY test_decode3to8 IS
END ENTITY;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.tests.ALL;

ARCHITECTURE test OF test_decode3to8 IS
    SIGNAL code : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL selection : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

    dut : ENTITY work.decoder(behav)
        PORT MAP(code, selection);

    stimulus : PROCESS IS
    BEGIN

        FOR i IN expected'RANGE LOOP
            code <= expected(i).sample_input;
            WAIT FOR expected(i).delay;
            ASSERT selection = expected(i).expected_output REPORT "UNEXPECTED OUTPUT" SEVERITY FAILURE;
        END LOOP;

    END PROCESS stimulus;

END ARCHITECTURE;

```