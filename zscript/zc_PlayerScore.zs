/* Copyright Alexander 'm8f' Kromm (mmaulwurff@gmail.com) 2019
 *
 * This file is a part of Lazy Points.
 *
 * Lazy Points is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 *
 * Lazy Points is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * Lazy Points.  If not, see <https://www.gnu.org/licenses/>.
 */

class zc_PlayerScore
{

// public: /////////////////////////////////////////////////////////////////////

  zc_PlayerScore init(int playerNumber)
  {
    _playerNumber = playerNumber;

    _timer       = new("zc_Timer"      ).init(TICKS_IN_SECOND * 3);
    _timerBonus  = new("zc_TimerBonus" ).init(_timer);
    _healthBonus = new("zc_HealthBonus").init(playerNumber);
    _counter     = new("zc_Counter"    ).init(playerNumber, _timerBonus, _healthBonus);

    if (playerNumber == consolePlayer)
    {
      _view      = new("zc_View"     ).init();
      _timerView = new("zc_TimerView").init(_timer);
      _bonusView = new("zc_BonusView").init(_timerBonus, _healthBonus);
      _tallyView = new("zc_TallyView").init();
    }

    return self;
  }

  ui
  void show(double fracTic)
  {
    if (gamestate == gs_TitleLevel || _view == NULL)
    {
      return;
    }

    int y = MARGIN;

    y += _view     .show(y);
    y += _timerView.show(y, fracTic);
    y += _bonusView.show(y);
    y += _tallyView.show(y);
  }

  play
  void countDamage(Actor damaged, int damage, Actor inflictor)
  {
    _counter.countDamage(damaged, damage, inflictor);
  }

  play
  void countDeath(Actor died)
  {
    _counter.countDeath(died);
  }

  play
  void tick()
  {
    _counter.countSecrets();

    _timer     .update();
    _timerBonus.update();
  }

  int getPlayerNumber() const
  {
    return _playerNumber;
  }

// private: ////////////////////////////////////////////////////////////////////

  const TICKS_IN_SECOND = 35;

  const MARGIN = 10;

// private: ////////////////////////////////////////////////////////////////////

  private int _playerNumber;

  private zc_Timer       _timer;
  private zc_TimerBonus  _timerBonus;
  private zc_HealthBonus _healthBonus;
  private zc_Counter     _counter;

  private zc_View        _view;
  private zc_TimerView   _timerView;
  private zc_BonusView   _bonusView;
  private zc_TallyView   _tallyView;

} // class zc_PlayerScore
