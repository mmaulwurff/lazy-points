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

class zc_View
{

// public: /////////////////////////////////////////////////////////////////////

  zc_View init()
  {
    _player       = players[consolePlayer];
    _interpolator = DynamicValueInterpolator.Create(0, 0.1, 1, 100);

    return self;
  }

  ui
  int show(int y)
  {
    int lineHeight = BigFont.GetHeight() * CleanYFac_1;

    if (!_player.mo)
    {
      return lineHeight;
    }

    y += MARGIN + lineHeight / 2;

    _interpolator.update(_player.mo.score);

    String scoreString = String.Format("%d", _interpolator.getValue());
    int    scoreWidth  = BigFont.StringWidth(scoreString) * CleanXFac_1;
    int    x           = (Screen.GetWidth() - scoreWidth) / 2;
    Screen.DrawText(BigFont, Font.CR_Blue, x, y, scoreString, DTA_CleanNoMove_1, true);

    return lineHeight * 2;
  }

// private: ////////////////////////////////////////////////////////////////////

  const MARGIN = 10;

// private: ////////////////////////////////////////////////////////////////////

  private PlayerInfo _player;

  private DynamicValueInterpolator _interpolator;

} // class zc_View
