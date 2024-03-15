unit Menu;

interface

const
  X = 5;
  Y = 2;
  Items = 8;  // количество пунктов меню

procedure PressAnyKey;   
procedure DrawMainMenu(x, y: integer);
function SelectMenu(x, y, count: integer): integer;
procedure MainMenu;

implementation

uses
  crt, Compl, ComplMatrix, Vect, CVect, Stacks, Queues, Favor;

procedure PressAnyKey;
begin
  while KeyPressed do readkey;
  ReadKey;
  if KeyPressed then Readkey;
end;

procedure DrawMainMenu(x, y: integer);
begin
  clrscr;
  gotoxy(x, y);     write('Комплексные числа');
  gotoxy(x, y + 1); write('Комплексные матрицы');
  gotoxy(x, y + 2); write('Векторы');
  gotoxy(x, y + 3); write('Комплексные векторы');
  gotoxy(x, y + 4); write('Стэки');
  gotoxy(x, y + 5); write('Очереди');
  gotoxy(x, y + 6); write('Избранное');
  gotoxy(x, y + 7); write('Выход');
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
  Items = 8; //количество пунктов меню
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
      7: MenuOfFavor;
      8:
        begin
          clrscr;
          ok := false;
        end;
    end
  end
end;

end.