unit Vect;

interface

const
  n = 3;

type
  vector = array [1..n] of real;

procedure AddVector(a, b: vector; var c: vector);         // Сложение векторов
function ScalMultVector(a, b: vector): real;              // Скалярное произведение векторов
procedure MultVector(a, b: vector; var c: vector);        // Произведение векторов
function MixMultVector(a, b, c: vector): real;            // Смешанное произведение векторов
procedure SubVector(a, b: vector; var c: vector);         // Разность векторов
function ModulVector(a: vector): real;                    // Модуль вектора
procedure ProdVector(p: real; a: vector; var c: vector);  // Умножение вектора на число
procedure MenuOfVect;

implementation

uses
  crt, menu;

procedure InputVectorOne(var a: vector);
var
  i: integer;
begin
  for i := 1 to n do
  begin
    GotoXY(i * 3 + 2, 2);
    read(a[i]);
  end;
end;

procedure InputVectorTwo(var a: vector);
var
  i: integer;
begin
  for i := 1 to n do
  begin
    GotoXY(i * 3 + 2, 4);
    read(a[i]);
  end;
end;

procedure InputVectorThree(var a: vector);
var
  i: integer;
begin
  for i := 1 to n do
  begin
    GotoXY(i * 3 + 2, 6);
    read(a[i]);
  end;
end;

procedure OutputVector(a: vector);
var
  i: integer;
begin
  for i := 1 to n do
  begin
    GotoXY(i * 3 + 2, 6);
    write(a[i], ' ');
  end;
end;

procedure AddVector(a, b: vector; var c: vector);
var
  i: integer;
begin
  for i := 1 to n do
    c[i] := a[i] + b[i];
end;

function ScalMultVector(a, b: vector): real;
var
  i: integer; s: real;
begin
  s := 0;
  for i := 1 to n do
    s := s + a[i] * b[i];
  Result := s;
end;

procedure MultVector(a, b: vector; var c: vector);
begin
  c[1] := a[2] * b[3] - a[3] * b[2];
  c[2] := a[3] * b[1] - a[1] * b[3];
  c[3] := a[1] * b[2] - a[2] * b[1];
end;

function MixMultVector(a, b, c: vector): real;
var
  d: vector;
begin
  MultVector(a, b, d);
  MixMultVector := ScalMultVector(d, c);
end;

procedure SubVector(a, b: vector; var c: vector);
var
  i: integer;
begin
  for i := 1 to n do
    c[i] := a[i] - b[i];
end;

function ModulVector(a: vector): real;
begin
  ModulVector := sqrt(ScalMultVector(a, a));
end;

procedure ProdVector(p: real; a: vector; var c: vector);
var
  i: integer;
begin
  for i := 1 to n do
    c[i] := p * a[i];
end;

procedure DrawVectMenu(x, y: integer);
begin
  clrscr;
  gotoxy(x, y);     write('1. Сложение векторов');
  gotoxy(x, y + 1); write('2. Скалярное произведение векторов');
  gotoxy(x, y + 2); write('3. Произведение векторов');
  gotoxy(x, y + 3); write('4. Смешанное произведение векторов');
  gotoxy(x, y + 4); write('5. Разность векторов');
  gotoxy(x, y + 5); write('6. Модуль вектора');
  gotoxy(x, y + 6); write('7. Умножение вектора на число');
  gotoxy(x, y + 7); write('Назад в главное меню');
end;

procedure MenuOfvect;
const
  Items = 8;
var
  ok:     boolean;
  a, b, c:  vector;
  n:      byte;
  p:    real;
begin
  ok := true; 
  while ok = true do
  begin
    DrawVectMenu(X, Y);
    n := SelectMenu(X - 2, Y, Items);
    case n of     
      1:
        begin
          clrscr;
          writeln('Введите вектор а: ');
          InputVectorOne(a);
          writeln('Введите вектор b: ');
          InputVectorTwo(b);
          AddVector(a, b, c);
          write('Сумма векторов a и b:');
          OutputVector(c);
          writeln(' ');
          PressAnyKey;
        end;
      2:
        begin
          clrscr;
          writeln('Введите вектор а: ');
          InputVectorOne(a);
          writeln('Введите вектор b: ');
          InputVectorTwo(b);
          writeln('Скалярное произведение векторов a и b: ', ScalMultVector(a, b));
          PressAnyKey;
        end;
      3:
        begin
          clrscr;
          writeln('Введите вектор а: ');
          InputVectorOne(a);
          writeln('Введите вектор b: ');
          InputVectorTwo(b);
          MultVector(a, b, c);
          write('Произведение векторов a и b:');
          OutputVector(c);
          writeln(' ');
          PressAnyKey;
        end;
      4:
        begin
          clrscr;
          writeln('Введите вектор а: ');
          InputVectorOne(a);
          writeln('Введите вектор b: ');
          InputVectorTwo(b);
          writeln('Введите вектор c: ');
          InputVectorThree(c);
          write('Смешанное произведение векторов a, b, c: ', MixMultVector(a, b, c));
          writeln(' ');
          PressAnyKey;
        end;
      5:
        begin
          clrscr;
          writeln('Введите вектор а: ');
          InputVectorOne(a);
          writeln('Введите вектор b: ');
          InputVectorTwo(b);
          SubVector(a, b, c);
          write('Разность векторов a и b:');
          OutputVector(c);
          writeln(' ');
          PressAnyKey;
        end;
      6: 
        begin
          clrscr;
          writeln('Введите вектор а: ');
          InputVectorOne(a);
          writeln('Модуль вектора a: ', ModulVector(a));
          PressAnyKey;
        end;
      7:
        begin
          clrscr;
          writeln('Введите вектор а: ');
          InputVectorOne(a);
          writeln('Введите число: ');
          GotoXY(5, 4);
          read(p);
          ProdVector(p, a, c);
          write('Умножение вектора на число: ');
          OutputVector(c);
          writeln(' ');
          PressAnyKey;
        end;
      8:
        begin
          clrscr;
          ok := false;
        end;
    end;
  end;
end;

end.