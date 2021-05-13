
ENTITY reginf IS
   PORT
   (
      d, clk, clr, pre, load, data   : IN STD_LOGIC;
      q1, q2, q3, q4, q5, q6, q7     : OUT STD_LOGIC
   );
END reginf;
ARCHITECTURE maxpld OF reginf IS

begin
   -- Register with active-high clock & asynchronous Preset
