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

class zc_TimerBonusView
{

// public: /////////////////////////////////////////////////////////////////////

  zc_TimerBonusView init(zc_TimerBonus timerBonus)
  {
    _timerBonus = timerBonus;

    return self;
  }

  ui
  int show(int y)
  {
    int lineHeight = OriginalBigFont.GetHeight() * CleanYFac_1;
    y += MARGIN + lineHeight / 2;

    int bonus = _timerBonus.getBonus();

    if (bonus == 0)
    {
      return 0;
    }

    String bonusString = String.Format("+%d", bonus);
    int    bonusWidth  = OriginalBigFont.StringWidth(bonusString) * CleanXFac_1;
    int    x           = (Screen.GetWidth() - bonusWidth) / 2;
    Screen.DrawText(OriginalBigFont, Font.CR_Blue, x, y, bonusString, DTA_CleanNoMove_1, true);

    return lineHeight * 2;
  }

// private: ////////////////////////////////////////////////////////////////////

  const MARGIN = 10;

// private: ////////////////////////////////////////////////////////////////////

  private zc_TimerBonus _timerBonus;

} // class zc_TimerBonusView
