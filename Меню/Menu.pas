unit Menu;

interface

const
  X = 5;
  Y = 2;
  Items = 10;  // количество пунктов меню

procedure PressAnyKey;
procedure DrawMainMenu(x, y: integer);
function SelectMenu(x, y, count: integer): integer;
procedure MainMenu;

implementation

uses
  crt, Compl, ComplMatrix, Vect, CVect, Stacks, Queues, Vertics, Files, Favor;

procedure PressAnyKey;
begin
  while KeyPressed do readkey;
  ReadKey;
  if KeyPressed then Readkey;
end;

procedure DrawMainMenu(x, y: integer);
begin
  clrscr;
  gotoxy(x, y);     write('1. Комплексные числа');
  gotoxy(x, y + 1); write('2. Комплексные матрицы');
  gotoxy(x, y + 2); write('3. Векторы');
  gotoxy(x, y + 3); write('4. Комплексные векторы');
  gotoxy(x, y + 4); write('5. Стэки');
  gotoxy(x, y + 5); write('6. Очереди');
  gotoxy(x, y + 6); write('7. Вертикальное меню');
  gotoxy(x, y + 7); write('8. Файлы'); 
  gotoxy(x, y + 8); write('9. Избранное');
  gotoxy(x, y + 9); write('Выход');
end;

function SelectMenu(x, y, count: integer): integer;
var
  i, current, key: integer;
begin
  Current := 1;
  while true do 
  begin
    //нарисовать
    for i := 1 to count do 
    begin
      gotoxy(x, y + i - 1);
      write(' ');
    end;
    gotoxy(x, y + current - 1);
    write('>');
    //обработать нажатую клавишу
    key := Ord(ReadKey);
    if key = 13 then break;
    if key = 38 then Current := current - 1;
    if key = 40 then Current := current + 1;
    if current <= 0  then current := count;
    if current > count  then current := 1;
  end;
  result := current;
end;

procedure MainMenu;
const
  Items = 10; //количество пунктов меню
var
  ok: boolean;
  n: byte;
begin
  ok := true; 
  while ok = true do
  begin
    DrawMainMenu(X, Y);
    n := SelectMenu(X - 2, Y, items);
    case n of  
      1: MenuOfComplex;
      2: MenuOfComplexMatrix;
      3: MenuOfVect;
      4: MenuOfCVect;
      5: MenuOfStacks;
      6: MenuOfQueues;
      7: MenuOfVertics;
      8: MenuOfFiles;
      9: MenuOfFavor;
      10:
        begin
          clrscr;
          ok := false;
        end;
    end
  end
end;

end.