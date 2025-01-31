const List<String> daysOfWeek = ['пн', 'вт', 'ср', 'чт', 'пт', 'сб', 'вс'];
const List<String> monthNames = [
  'Январь',
  'Февраль',
  'Март',
  'Апрель',
  'Май',
  'Июнь',
  'Июль',
  'Август',
  'Сентябрь',
  'Октябрь',
  'Ноябрь',
  'Декабрь',
];
const numberDaysWeek = 7;
const minCalendarHeight = 40.0;
const maxCalendarHeight = 240.0;
const autoExpandingHeight = minCalendarHeight + 9;
const autoCollapsingHeight = maxCalendarHeight - 9;
const opacityDuration = Duration(milliseconds: 250);
const expandingDuration = Duration(milliseconds: 350);
const pageControllerInitialPage = 4242;
const swipeDuration =  Duration(milliseconds: 400);
