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

/**
 * This class is an entry point for Lazy Points.
 */
class zc_Dispatcher : EventHandler
{

// public: /////////////////////////////////////////////////////////////////////

  override
  void OnRegister()
  {
    _timer       = new("zc_Timer"      ).init(TICKS_IN_SECOND * 3);
    _timerBonus  = new("zc_TimerBonus" ).init(_timer);
    _healthBonus = new("zc_HealthBonus").init(consolePlayer);
    _counter     = new("zc_Counter"    ).init(consolePlayer, _timerBonus, _healthBonus);
    _spawner     = new("zc_Spawner"    ).init();

    _view        = new("zc_View"       ).init();
    _timerView   = new("zc_TimerView"  ).init(_timer);
    _bonusView   = new("zc_BonusView"  ).init(_timerBonus, _healthBonus);
  }

  override
  void RenderOverlay(RenderEvent event)
  {
    if (gamestate == gs_TitleLevel)
    {
      return;
    }

    int y = MARGIN;

    y += _view     .show(y);
    y += _timerView.show(y);
    y += _bonusView.show(y);
  }

  override
  void WorldThingDamaged(WorldEvent event)
  {
    _counter.countDamage(event.thing, event.damage, event.damageSource);
  }

  override
  void WorldThingDied(WorldEvent event)
  {
    _counter.countDeath(event.thing);
  }

  override
  void WorldTick()
  {
    _counter.countSecrets();

    _timer     .update();
    _timerBonus.update();
  }

  override
  void WorldThingSpawned(WorldEvent event)
  {
    _spawner.spawnScoreFor(event.thing);
  }

// private: ////////////////////////////////////////////////////////////////////

  const TICKS_IN_SECOND = 35;

  const MARGIN = 10;

// private: ////////////////////////////////////////////////////////////////////

  private zc_Counter     _counter;
  private zc_Spawner     _spawner;
  private zc_Timer       _timer;
  private zc_TimerBonus  _timerBonus;
  private zc_HealthBonus _healthBonus;

  private zc_View        _view;
  private zc_TimerView   _timerView;
  private zc_BonusView   _bonusView;

} // class zc_Dispatcher
