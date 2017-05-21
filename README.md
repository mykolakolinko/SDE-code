# SDE-code
ОСТАННІЙ АПДЕЙТ 21.00
Це наближення Ейлера для вправи 1
Тут є три файли:

init.m - єдиний, який потрібновам змінювати. 
Тут ви вписуєте свої коефіцієнти. Тут це вже просто коефієнти, не функції.
Можна змінювати кількість точок розбиття N. Це змінить діаметр розбиття. 
Зараз там 101 точка і Т=1, тобто діаметр - 1/100.
Можна змінювати кількість траекторій n_iter. Зараз їх 1000.
Змінили - запустіть init.m файл. 
Тоді зміниться файл par.mat, де ми зберігаємо параметри задачі. 
Лиш після цього запускайте euler.m.

euler.m - власне код. X - наближеня Ейлера, x - точний розв'язок.
Якщо забрати # з 10 рядка, на кожному ітераційному кроці вискакуватиме графік X та x (figure 1)
Збіжність повільна (порядку O(sqrt(N))). 
X - хрестики, x - кружечки.
Зараз цей рядок закоментовано (починаємо з #), бо графік кожної траекторії заповільнює код.
Потрібні траекторії наближень Ейлера і точного розвязку - знамайте #
В кінці коду проводимо усереднення наближень Ейлера і порівнюєм його з матсподіванням точного розв'язку (figure 2).
З позначеннями та ж історія:
MX - хрестики, mx - кружечки.
Ви отримаєте значенн mean, medium і std (середнє, медіана і сер кв відхилення рівномірної норми різниць)
Їх треба занести в табличку
Див. Shatokhin.pdf.


Розв'язки Міші Шатохіна:
Shatokhin.pdf
Shatokhin.py
Shatokhin.cpp
Shatokhin.tex
Там є розв'язок вправи 1 для загального випадку (a,b,c,d - довільні), а також вправа 2.

Важливо:
1. У нас сталі коефіцієнти, тому я спростив код, щоб він працював швидше.
Якщо коефіцієнти не сталі, варто працювати з файлами init_gen.m, par_gen.m і euler_gen.m .
Це ті файли, що я висилав вк,
з одним істотнім виправленням в 1 рядку init.m: dt = T/(N-1), а не 1/(N-1).
Проблема: Наближення інтегруванням надто сильно коливається для деяких значень параметрів (від'ємне a наче) і графіки не будуватимуться.
2. Точний розв'язок і його матсподівання ми знаємо тільки для b = d = 0 і b = c = 0.
Інакше там діч, інтеграли з W. Див. Shatokhin.pdf.
3. Для a>0 будуть погані значення в табличці.
Беріть його зі знаком мінус.
Юлія Степанівна одобряє.
3. Якщо вам потрібен графік кожної траекторії в окремому вікні замініть figure(1) на figure(j), а figure(2) на figure(n_iter+1).
Caution: для великої кількості траекторій це брєд.
4. Якщо вам потрібно 10 000 траекторій, чекати на графік матсподівань доведеться ДУЖЕ довго.
Для 1000 траекторій і діаметра розбиття 1/1000 працює теж довго - 3 хв (T=2).
Для 1000 траекторій і діаметра розбиття 1/100 за 15 секунд (T=2).

Успіхів :)
