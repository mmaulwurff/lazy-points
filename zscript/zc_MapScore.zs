/* Copyright Alexander 'm8f' Kromm (mmaulwurff@gmail.com) 2019-2020
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

class zc_MapScore
{

// public: /////////////////////////////////////////////////////////////////////

  zc_MapScore init(int playerNumber)
  {
    _playerNumber  = playerNumber;
    _startingScore = players[_playerNumber].mo.score;

    return self;
  }

// public: /////////////////////////////////////////////////////////////////////

  void save()
  {
    if (_playerNumber != consolePlayer)
    {
      return;
    }

    int        score           = players[_playerNumber].mo.score - _startingScore;
    CVar       scoreCVar       = CVar.FindCVar("lp_score");
    String     scoreString     = scoreCVar.GetString();
    let        persistentScore = Dictionary.FromString(scoreString);
    String     checksum        = Level.GetChecksum();
    String     topString       = persistentScore.At(checksum);

    Array<int> top;

    if (topString.Length() == 0)
    {
      top.Push(score);
      for (int i = 1; i < N_TOP; ++i)
      {
        top.Push(0);
      }
    }
    else
    {
      Array<String> split;
      topString.Split(split, ":");
      for (int i = 0; i < N_TOP; ++i)
      {
        top.Push(split[i].ToInt());
      }

      for (int i = 0; i < N_TOP; ++i)
      {
        if (score > top[i])
        {
          top.Insert(i, score);
          break;
        }
      }
    }

    String newTopString;
    for (int i = 0; i < N_TOP; ++i)
    {
      newTopString.AppendFormat("%d:", top[i]);
    }

    persistentScore.Insert(checksum, newTopString);
    console.printf("%s", persistentScore.ToString());
    scoreCVar.SetString(persistentScore.ToString());
  }

  static
  Dictionary getScore()
  {
    CVar   scoreCVar       = CVar.FindCVar("lp_score");
    String scoreString     = scoreCVar.GetString();
    let    persistentScore = Dictionary.FromString(scoreString);

    return persistentScore;
  }

// private: ////////////////////////////////////////////////////////////////////

  const N_TOP = 10;

  private int _playerNumber;
  private int _startingScore;

} // class zc_MapScore
