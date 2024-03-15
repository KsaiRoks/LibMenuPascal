unit ComplMatrix;

interface

uses
  Compl;

const
  n = 2;

type
  Matrix = array [1..n, 1..n] of Complex;

procedure OutputMatrix(a: matrix);                          // Вывод матрицы к.ч.
procedure AddMatrix(a, b: matrix; var c: matrix);           // Сложение матриц к.ч.
procedure MultMatrix(a, b: matrix; var c: matrix);          // Умножение матриц к.ч.
procedure ProdMatrix(a: real; B: Matrix; var C: Matrix);    // Умножение матрицы к.ч. на число
procedure zeroMatrix(var A: Matrix);                        // Нулевая матрица к.ч.
procedure oneMatrix(var A: Matrix);                         // Еденичная матрица к.ч.
function NormMatrix(a: matrix): real;                       // Норма матрицы
procedure expMatrix(a: Matrix; var s: matrix);              // Экспонента матрицы
procedure MenuOfComplexMatrix;                              // Меню

implementation

uses
  crt, menu;

procedure InputMatrixOne(var a: matrix);
var
  i, j: integer; u: Complex;
begin
  for i := 1 to n do
    for j := 1 to n do
    begin
      GotoXY(7 * j + 1, i + 1);
      read(U.Re);
      GotoXY(7 * j + 4, i + 1);
      read(U.Im);
      a[i, j] := U;
    end;
end;

procedure InputMatrixTwo(var a: matrix);
var
  i, j: integer; u: Complex;
begin
  for i := 1 to n do
    for j := 1 to n do
    begin
      GotoXY(7 * j + 1, i + 4);
      read(U.Re);
      GotoXY(7 * j + 4, i + 4);
      read(U.Im);
      a[i, j] := U;
    end;
end;

procedure OutputMatrix(a: matrix);
var
  i, j: integer;
begin
  for i := 1 to n do
    for j := 1 to n do
    begin
      GotoXY(7 * j + 1, i + 7);
      Output(a[i, j]);
    end;
end;

procedure FIXOutputMatrix(a: matrix);
var
  i, j: integer;
begin
  for i := 1 to n do
    for j := 1 to n do
    begin
      GotoXY(7 * j + 1, i + 1);
      Output(a[i, j]);
    end;
end;

procedure FIXOutputMatrixTwo(a: matrix);
var
  i, j: integer;
begin
  for i := 1 to n do
    for j := 1 to n do
    begin
      GotoXY(7 * j + 1, i + 4);
      Output(a[i, j]);
    end;
end;

procedure addMatrix(a, b: Matrix; var c: Matrix);
var
  i, j: integer;
begin
  for i := 1 to n do
    for j := 1 to n do
      Add(a[i, j], b[i, j], c[i, j]);
end;

procedure MultMatrix(a, b: matrix; var c: matrix);
var
  i, j, k: integer; P, S: Complex;
begin
  for i := 1 to n do 
    for j := 1 to n do 
    begin
      Zero(S);
      for k := 1 to n do
      begin
        Mult(a[i, k], b[k, j], P);
        add(S, P, S);
      end;
      c[i, j] := S;
    end;
end;

procedure ProdMatrix(a: real; B: Matrix; var C: Matrix);
var
  i, j: integer;
begin
  for i := 1 to n do  
    for j := 1 to n do
      Prod(a, B[i, j], c[i, j]);           
end;

procedure zeroMatrix(var A: Matrix);
var
  i, j: integer;
begin
  for i := 1 to n do  
    for j := 1 to n do
      zero(a[i, j]);           
end;

procedure oneMatrix(var A: Matrix);
var
  i, j: integer;
begin
  for j := 1 to n do  
    for i := 1 to n do                              
      Zero(A[i, j]);
  for i := 1 to n do
    for j := 1 to n do
      if i = j then One(A[i, j])
end;

function NormMatrix(a: matrix): real;
var
  i, j: Integer; p, s: real;
begin
  p := 0;
  for i := 1 to n do                            
  begin
    s := 0;
    for j := 1 to n do
    begin
      s := s + Modul(a[i, j]);
      if s >= p then p := s;
    end; 
  end;
  NormMatrix := p;
end;

procedure expMatrix(a: Matrix; var s: matrix);
const
  eps = 0.001;
var
  k: integer; P: matrix;

begin
  OneMatrix(P);
  OneMatrix(S);
  K := 0;               
  while normMatrix(p) >= eps do 
  begin
    K := K + 1;
    MultMatrix(p, a, p);
    ProdMatrix(1 / k, p, p);
    AddMatrix(s, p, s);
  end;
end;

procedure DrawComplexMatrixMenu(x, y: integer);
begin
  clrscr;
  gotoxy(x, y);     write('Сложение комплексных матриц');
  gotoxy(x, y + 1); write('Умножение комплексных матриц');
  gotoxy(x, y + 2); write('Умножение комплексной матрицы на скаляр');
  gotoxy(x, y + 3); write('Нулевая матрица');
  gotoxy(x, y + 4); write('Еденичная матрица');
  gotoxy(x, y + 5); write('Норма матрицы');
  gotoxy(x, y + 6); write('Экспонента матрицы');
  gotoxy(x, y + 7); write('Назад в главное меню');
end;

procedure MenuOfComplexMatrix;
const
  Items = 8;
var
  ok:     boolean;
  U, V, W:  matrix;
  n:      byte;
  a:    real;
begin
  ok := true; 
  while ok = true do
  begin
    DrawComplexMatrixMenu(X, Y);
    n := SelectMenu(X - 2, Y, Items);
    case n of     
      1:
        begin
          clrscr;
          Writeln('Введите 1 комплексную матрицу:');
          InputMatrixOne(u);
          Writeln('Введите 2 комплексную матрицу:');
          InputMatrixTwo(v);
          addMatrix(u, v, w);
          Writeln('Сумма данных комплексных матриц:');
          OutputMatrix(w);
          PressAnyKey;
        end;
      2:
        begin
          clrscr;
          Writeln('Введите 1 комплексную матрицу:');
          InputMatrixOne(u);
          Writeln('Введите 2 комплексную матрицу:');
          InputMatrixTwo(v);
          multMatrix(u, v, w);
          Writeln('Произведение данных комплексных матриц:');
          OutputMatrix(w);
          PressAnyKey;
        end;
      3:
        begin
          clrscr;
          Writeln('Введите число:');
          gotoXY(8, 2);
          read(a);
          gotoXY(1, 4);
          Writeln('Введите комплексную матрицу:');
          InputMatrixTwo(v);
          prodMatrix(a, v, w);
          Writeln('Произведение матрицы на число:');
          OutputMatrix(w);
          PressAnyKey;
        end;
      4:
        begin
          clrscr;
          zeroMatrix(u);
          Writeln('Ноль матрица:');
          FIXOutputMatrix(u);
          PressAnyKey;
        end;
      5:
        begin
          clrscr;
          oneMatrix(u);
          Writeln('Еденичная матрица:');
          FIXOutputMatrix(u);
          PressAnyKey;
        end;
      6:
        begin
          clrscr;
          Writeln('Введите комплексную матрицу:');
          InputMatrixOne(u);
          Writeln('Норма матрицы: ', normMatrix(u));
          PressAnyKey;
        end;
      7:
        begin
          clrscr;
          Writeln('Введите комплексную матрицу:');
          InputMatrixOne(u);
          expMatrix(u, w);
          Writeln('Экспанента матрицы: ');
          FIXOutputMatrixTwo(w);
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