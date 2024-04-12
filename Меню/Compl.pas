unit Compl;

interface

type
  Complex = record Re, Im: real end;

procedure Output(W: complex);                           // ввод к.ч.
procedure Add(U, V: Complex; var W: Complex);           // сложение 2 к.ч.
procedure Mult(U, V: Complex; var W: Complex);          // умножение 2 к.ч.
procedure Inv(U: complex; var W: Complex);              // инверсия (1/z) к.ч.
procedure Divz(U, V: Complex; var W: Complex);          // деление к.ч.
procedure Zero(var U: complex);                         // к.ч. ноль
procedure One(var U: complex);                          // к.ч. еденица
procedure Prod(a: real; U: Complex; var W: Complex);    // умножение к.ч. на скаляр
function Modul(U: complex): real;                       // модуль к.ч.
procedure Codj(Z: Complex; var W: Complex);
procedure sub(U, V: Complex; var W: Complex);
procedure expC(U: Complex; var W: Complex);             // экспанента к.ч.
procedure CosC(U: Complex; var W: Complex);             // косинус к.ч.
procedure SinC(U: Complex; var W: Complex);             // синус к.ч.
procedure InputComplexOne(var U: Complex);
procedure InputComplexTwo(var U: Complex);
procedure OutputComplex(var U: Complex);
procedure FIXOutputComplex(var U: Complex);
procedure MenuOfComplex;                                // меню

implementation

uses
  crt, menu;

procedure InputComplexOne(var U: Complex);
begin
  gotoXY(7, 2);
  read(U.Re);
  gotoXY(10, 2);
  read(U.Im);
end;

procedure InputComplexTwo(var U: Complex);
begin
  gotoXY(7, 4);
  read(U.Re);
  gotoXY(10, 4);
  read(U.Im);
end;

procedure OutputComplex(var U: Complex);
begin
  gotoXY(7, 6);
  output(u);
end;

procedure FIXOutputComplex(var U: Complex);
begin
  gotoXY(7, 4);
  output(u);
end;

procedure Output(W: complex);
begin
  if W.Im >= 0 then
    write(W.Re, '+', W.Im, 'i')
  else
    write(W.Re, W.Im, 'i');
  writeln;
end;

procedure Add(U, V: Complex; var W: Complex);
begin
  W.Re := U.Re + V.Re;
  W.Im := U.Im + V.Im;
end;

procedure Mult(U, V: Complex; var W: Complex);
begin
  W.Re := U.Re * V.Re - U.Im * V.Im;
  W.Im := U.Re * V.Im + U.Im * V.Re;
end;

procedure Inv(U: complex; var W: Complex);
var
  Zn: real;
begin
  Zn := sqr(U.Re) + sqr(U.Im);
  W.Re := U.re / Zn;
  W.Im := -U.Im / Zn;
end;

procedure Divz(U, V: Complex; var W: Complex);
var
  Z: complex;
begin
  inv(V, Z);
  Mult(U, Z, W);
end;

procedure Zero(var U: complex);
begin
  U.Re := 0;
  U.Im := 0;
end;

procedure One(var U: complex);
begin
  U.Re := 1;
  U.Im := 0;
end;

procedure Prod(a: real; U: Complex; var W: Complex);
begin
  W.Re := a * U.re;
  W.Im := a * U.Im;
end;

function Modul(U: complex): real;
begin
  Modul := sqrt(sqr(U.Re) + sqr(U.Im));
end;

procedure Codj(Z: Complex; var W: Complex);
begin
  W.Re := Z.Re;
  W.Im := -Z.Im;
end;

procedure sub(U, V: Complex; var W: Complex);
begin
  W.Re := U.Re - V.Re;
  W.Im := U.Im - V.Im;
end;

procedure expC(U: Complex; var W: Complex);
const
  eps = 0.001;
var
  K: integer; P: Complex;
begin
  One(P);
  One(W);
  k := 0;
  while (Modul(p) >= eps) do
  begin
    k := k + 1;
    Mult(P, U, P);
    Prod(1 / K, P, P);
    Add(W, P, W);
  end;
end;

procedure CosC(U: Complex; var W: Complex);
const
  eps = 0.001;
var
  K: integer; P, U2: Complex;
begin
  k := 0;
  One(p);
  One(W);
  Mult(U, U, U2);
  while (Modul(P) >= eps) do
  begin
    k := k + 2;
    Mult(P, U2, P);
    Prod(-1 / k / (k - 1), P, P);
    Add(W, P, W);
  end;
end;

procedure SinC(U: Complex; var W: Complex);
const
  eps = 0.001;
var
  K: integer; P, U2: Complex;
begin
  k := 0;
  One(p);
  One(w);
  Mult(U, U, U2);
  while (Modul(P) >= eps) do
  begin
    k := k + 2;
    Mult(P, U2, P);
    Prod(-1 / k / (k + 1), P, P);
    Add(W, P, W);
  end;
end;

procedure DrawComplexMenu(x, y: integer);
begin
  clrscr;
  gotoxy(x, y);     write('1. Сложение комплексных чисел');
  gotoxy(x, y + 1); write('2. Умножение комплексных чисел');
  gotoxy(x, y + 2); write('3. Инверсия комплексного числа');
  gotoxy(x, y + 3); write('4. Деление комплексных чисел');
  gotoxy(x, y + 4); write('5. Умножение комплексного числа на скаляр');
  gotoxy(x, y + 5); write('6. Модуль комплексного числа');
  gotoxy(x, y + 6); write('Назад в главное меню');
end;

procedure MenuOfComplex;
const
  Items = 7;
var
  ok: boolean;
  U, V, W: Complex;
  a: real;
  n: byte;
begin
  ok := true; 
  while ok = true do
  begin
    DrawComplexMenu(X, Y);
    n := SelectMenu(X - 2, Y, Items);
    case n of     
      1:
        begin
          clrscr;
          Writeln('Введите первое комплексное число: ');
          InputComplexOne(U);
          Writeln('Введите второе комплексное число: ');
          InputComplexTwo(V);
          Add(U, V, W);
          Writeln('Ответ: ');
          OutputComplex(W);
          PressAnyKey;
        end;      
      2:
        begin
          clrscr;
          Writeln('Введите первое комплексное число: ');
          InputComplexOne(U);
          Writeln('Введите второе комплексное число: ');
          InputComplexTwo(V);
          Mult(U, V, W); 
          Writeln('Ответ: ');
          OutputComplex(W);
          PressAnyKey;
        end;      
      3:
        begin
          clrscr;
          Writeln('Введите комплексное число: ');
          InputComplexOne(U);
          Inv(U, W);
          Writeln('Ответ: ');
          FIXOutputComplex(W);
          PressAnyKey;
        end;
      4:
        begin
          clrscr;
          Writeln('Введите первое комплексное число: ');
          InputComplexOne(U);
          Writeln('Введите второе комплексное число: ');
          InputComplexTwo(V);
          Divz(U, V, W); 
          Writeln('Ответ: ');
          OutputComplex(W);
          PressAnyKey;
        end;
      5:
        begin
          clrscr;
          Writeln('Введите комплексное число: ');
          InputComplexOne(U);
          Writeln('Введите скаляр: ');
          gotoXY(7, 4);
          readln(a);
          Prod(a, U, W);
          Writeln('Ответ: ');
          OutputComplex(W);
          PressAnyKey;
        end;
      6:
        begin
          clrscr;
          Writeln('Введите комплексное число: ');
          InputComplexOne(U);
          writeln('Ответ: ', Modul(U));
          PressAnyKey;
        end;
      7:
        begin
          clrscr;
          ok := false;
        end;
    end;
  end;
end;

end.