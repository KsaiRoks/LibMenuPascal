unit Favor;

interface

uses
  Compl;

const
  n = 2;

procedure MenuOfFavor;// меню

implementation

uses
  crt, menu;

procedure DrawFavorMenu(x, y: integer);
begin
  clrscr;
  gotoxy(x, y);     write('Отрицательная мнимая часть');
  gotoxy(x, y + 1); write('Вычитание комплексных чисел');
  gotoxy(x, y + 2); write('Комплексное e');
  gotoxy(x, y + 3); write('Косинус комплексного числа');
  gotoxy(x, y + 4); write('Синус комплексного числа');
  gotoxy(x, y + 5); write('Назад в главное меню');
end;

procedure MenuOfFavor;
const
  Items = 6;
var
  ok: boolean;
  U, V, W: Complex;
  a: real;
  n: byte;
begin
  ok := true; 
  while ok = true do
  begin
    DrawFavorMenu(X, Y);
    n := SelectMenu(X - 2, Y, Items);
    case n of     
      1:
        begin
          clrscr;
          Writeln('Введите первое комплексное число: ');
          InputComplexOne(U);
          Codj(U, W);
          Writeln('Ответ: ');
          FIXOutputComplex(W);
          PressAnyKey;
        end;
      2:
        begin
          clrscr;
          Writeln('Введите первое комплексное число: ');
          InputComplexOne(U);
          Writeln('Введите второе комплексное число: ');
          InputComplexTwo(V);
          sub(U, V, W);
          Writeln('Ответ: ');
          OutputComplex(W);
          PressAnyKey;
        end;
      3:
        begin
          clrscr;
          Writeln('Введите комплексное число: ');
          InputComplexOne(U);
          expC(U, W); 
          Writeln('Ответ: ');
          FIXOutputComplex(W);
          PressAnyKey;
        end;
      4:
        begin
          clrscr;
          Writeln('Введите комплексное число: ');
          InputComplexOne(U);
          cosC(U, W); 
          Writeln('Ответ: ');
          FIXOutputComplex(W);
          PressAnyKey;
        end;
      5:
        begin
          clrscr;
          Writeln('Введите комплексное число: ');
          InputComplexOne(U);
          sinC(U, W); 
          Writeln('Ответ: ');
          FIXOutputComplex(W);
          PressAnyKey;
        end;
      6:
        begin
          clrscr;
          ok := false;
        end;
    end;
  end;
end;

end.