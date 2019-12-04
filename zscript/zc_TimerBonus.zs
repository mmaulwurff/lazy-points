/* Copyright Alexander 'm8f' Kromm (mmaulwurff@gmail.com) 2019
 *
 * This file is a part of Zcore.
 *
 * Zcore is free software: you can redistribute it and/or modify it under the
 * terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 *
 * Zcore is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
 * A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * Zcore.  If not, see <https://www.gnu.org/licenses/>.
 */

class zc_TimerBonus
{

// public: /////////////////////////////////////////////////////////////////////

  zc_TimerBonus init(zc_Timer timer)
  {
    _bonus = 0;
    _timer = timer;

    return self;
  }

  int getUpdatedBonus()
  {
    _bonus =(_timer.getCount())
      ? min(MAX_TIMER_BONUS, _bonus + TIMER_BONUS_STEP)
      : 0;

    _timer.reset();

    return _bonus;
  }

  int getBonus() const
  {
    return _bonus;
  }

// private: ////////////////////////////////////////////////////////////////////

  const MAX_TIMER_BONUS  = 500;
  const TIMER_BONUS_STEP =  10;

// private: ////////////////////////////////////////////////////////////////////

  private int      _bonus;
  private zc_Timer _timer;

} // class zc_TimerBonus
