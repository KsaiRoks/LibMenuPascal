unit CVect;

interface

uses
  compl;

const
  n = 3;

type
  cvector = array [1..n] of complex;

procedure AddCVector(U, V: CVector; var W: CVector);// Сумма комплексных векторов
procedure scalarCVector(U, V: CVector; var Z: Complex);// Скалярное произведение комплексных векторов
procedure multCVector(U, V: CVector; var W: CVector);
procedure MixMultCVector(U, V, W: Cvector; var Z: Complex);//Смешанное произведение 3 комплексных векторов
procedure modulCVector(U: CVector; var Z: real);
procedure MenuOfCVect;

implementation

uses
  crt, compl, menu;

procedure InputCVectorOne(var a: CVector);
var
  i: integer; u: complex;
begin
  for i := 1 to n do
  begin
    GotoXY(7 * i, 2);
    read(U.Re);
    GotoXY(7 * i + 3, 2);
    read(U.Im);
    a[i] := U;
  end;
end;

procedure InputCVectorTwo(var a: CVector);
var
  i: integer; u: complex;
begin
  for i := 1 to n do
  begin
    GotoXY(7 * i, 4);
    read(U.Re);
    GotoXY(7 * i + 3, 4);
    read(U.Im);
    a[i] := U;
  end;
end;

procedure InputCVectorThree(var a: CVector);
var
  i: integer; u: complex;
begin
  for i := 1 to n do
  begin
    GotoXY(7 * i, 6);
    read(U.Re);
    GotoXY(7 * i + 3, 6);
    read(U.Im);
    a[i] := U;
  end;
end;

procedure OutputCVector(U: CVector);//Вывод
var
  i, j: integer;
begin
  for i := 1 to n do
  begin
    GotoXY(7 * i, 6);
    output(U[i]); write(' '); 
  end;
end;

procedure FIXOutputCVector(U: CVector);//Вывод
var
  i, j: integer;
begin
  for i := 1 to n do
  begin
    GotoXY(7 * i, 8);
    output(U[i]); write(' '); 
  end;
end;

procedure AddCVector(U, V: CVector; var W: CVector);
var
  i: integer;
begin
  for i := 1 to n do
    Add(U[i], V[i], W[i]);
end;

procedure scalarCVector(U, V: CVector; var Z: Complex);
var
  i: integer; w: complex;
begin
  for i := 1 to n do
  begin
    Codj(U[i], W);
    Mult(V[i], W, W);
    add(Z, W, Z);
  end;
end;

procedure multCVector(U, V: CVector; var W: CVector);
var
  Z1, Z2: Complex;
begin
  mult(U[2], V[3], Z1); mult(U[3], V[2], Z2); Sub(Z1, Z2, W[1]);
  mult(U[3], V[1], Z1); mult(U[1], V[3], Z2); Sub(Z1, Z2, W[2]);
  mult(U[1], V[2], Z1); mult(U[2], V[1], Z2); Sub(Z1, Z2, W[3]);
end;

procedure MixMultCVector(U, V, W: Cvector; var Z: Complex);//Смешанное произведение 3 комплексных векторов
var
  Y: CVector;
begin
  multCVector(U, V, Y);
  ScalarCvector(Y, W, Z);  
end;

procedure modulCVector(U: CVector; var Z: real);
var
  i: integer; s: real;
begin
  s := 0;
  for i := 1 to n do
  begin
    s := s + sqr(u[i].Re) + sqr(u[i].Im);
    z := sqrt(s);
  end;
end;

procedure DrawCVectMenu(x, y: integer);
begin
  clrscr;
  gotoxy(x, y);     write('1. Сумма комплексных векторов');
  gotoxy(x, y + 1); write('2. Скалярное произведение комплексных векторов');
  gotoxy(x, y + 2); write('3. Векторное произведение комплексных векторов');
  gotoxy(x, y + 3); write('4. Смешанное произведение комплексных векторов');
  gotoxy(x, y + 4); write('5. Модуль комплексного вектора');
  gotoxy(x, y + 5); write('Назад в главное меню');
end;

procedure MenuOfCVect;
const
  Items = 6;
var
  ok:     boolean;
  a, b, c:  cvector;
  n:      byte;
  z:    real;
  p: complex;
begin
  ok := true; 
  while ok = true do
  begin
    DrawCVectMenu(X, Y);
    n := SelectMenu(X - 2, Y, Items);
    case n of     
      1:
        begin
          clrscr;
          writeln('Введите вектор а: ');
          InputCVectorOne(a);
          writeln('Введите вектор b: ');
          InputCVectorTwo(b);
          AddCVector(a, b, c);
          writeln('Сумма комплексных векторов a и b:');
          OutputCVector(c);
          PressAnyKey;
        end;
      2:
        begin
          clrscr;
          writeln('Введите вектор а: ');
          InputCVectorOne(a);
          writeln('Введите вектор b: ');
          InputCVectorTwo(b);
          scalarCVector(a, b, p);
          writeln('Скалярное произведение комплексных векторов a и b:');
          gotoXY(7, 6);
          Output(p);
          PressAnyKey;
        end;
      3:
        begin
          clrscr;
          writeln('Введите вектор а: ');
          InputCVectorOne(a);
          writeln('Введите вектор b: ');
          InputCVectorTwo(b);
          multCVector(a, b, c);
          writeln('Векторное произведение комплексных векторов a и b:');
          OutputCVector(c);
          PressAnyKey;
        end;
      4:
        begin
          clrscr;
          writeln('Введите вектор а: ');
          InputCVectorOne(a);
          writeln('Введите вектор b: ');
          InputCVectorTwo(b);
          writeln('Введите вектор c: ');
          InputCVectorThree(c);
          MixMultCVector(a, b, c, p);
          writeln('Смешанное произведение комплексных векторов a, b и c:');
          gotoXY(7, 8);
          Output(p);
          PressAnyKey;
        end;
      5:
        begin
          clrscr;
          writeln('Введите вектор а: ');
          InputCVectorOne(a);
          ModulCVector(a, z);
          writeln('Модуль комплексного вектора a:');
          GoToXY(7, 4);
          writeln(z);
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