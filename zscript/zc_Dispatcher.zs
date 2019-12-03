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

/**
 * This class is an entry point for Zcore.
 *
 * Scoring:
 *
 * 1. Damage: players get points for the amount of damage they inflict on monsters.
 * 2. Kills: players get points for 10% of killed monsters.
 * 3. Secrets: finding a secret gives 250 points.
 * 4. Map items: collecting an item that counts for item counts gives 5 points.
 *
 *
 */
class zc_Dispatcher : EventHandler
{

// public: /////////////////////////////////////////////////////////////////////

  override
  void OnRegister()
  {
    _view    = new("zc_View").init();
    _counter = new("zc_Counter").init(consolePlayer);
    _spawner = new("zc_Spawner").init();
  }

  override
  void RenderOverlay(RenderEvent event)
  {
    _view.show();
  }

  override
  void WorldThingDamaged(WorldEvent event)
  {
    _counter.countDamage(event.damage, event.damageSource);
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
  }

  override
  void WorldThingSpawned(WorldEvent event)
  {
    _spawner.spawnScoreFor(event.thing);
  }

// private: ////////////////////////////////////////////////////////////////////

  private zc_View    _view;
  private zc_Counter _counter;
  private zc_Spawner _spawner;

} // class zc_Dispatcher
