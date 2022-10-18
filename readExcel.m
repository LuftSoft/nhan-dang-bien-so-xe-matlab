function x = readExcel(filename)
%----------------XU LY DATA TU FILE-------------------
data = readtable(filename);
STT = data.STT; STT = string(STT);
NGAY = data.NGAY; NGAY = string(NGAY);
GIO = string(datestr(data.GIO,'HH:MM:SS')); GIO = string(GIO);
BIENSOXE = data.BIENSOXE; BIENSOXE = string(BIENSOXE);
data = cellstr([STT NGAY GIO BIENSOXE]);
x = data;
%----------------XU LY DATA TU FILE-------------------