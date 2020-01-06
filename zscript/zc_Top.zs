/* Copyright Alexander 'm8f' Kromm (mmaulwurff@gmail.com) 2020
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

class zc_Top : OptionMenu
{
  override void Init(Menu parent, OptionMenuDescriptor desc)
  {
    Super.Init(parent, desc);
    mDesc.mItems.Clear();

    if (gamestate != GS_LEVEL && gamestate != GS_INTERMISSION)
    {
      String label = "No map detected.";
      addLabel(label);
      return;
    }

    CVar   scoreCVar       = CVar.FindCVar("lp_score");
    String scoreString     = scoreCVar.GetString();
    let    persistentScore = Dictionary.FromString(scoreString);
    String checksum        = Level.GetChecksum();
    String topString       = persistentScore.At(checksum);

    if (topString.Length() == 0)
    {
      String label = "No scores found. Something is wrong.";
      addLabel(label);
      return;
    }

    Array<String> split;
    topString.split(split, ":");

    int maxLength = 0;
    for (int i = 0; i < zc_MapScore.N_TOP; ++i)
    {
      int length = split[i].Length();
      if (length > maxLength)
      {
        maxLength = length;
      }
    }

    // %% will become %. Adds spacing to string output.
    String format = String.Format("%%d. %%%ds", maxLength);

    for (int i = 0; i < zc_MapScore.N_TOP; ++i)
    {
      String label = String.Format(format, i + 1, split[i]);
      addCommand(label);
    }
  }

// private: ////////////////////////////////////////////////////////////////////

  private
  void addLabel(String label)
  {
    mDesc.mItems.Push(new("OptionMenuItemStaticText").InitDirect(label, Font.CR_WHITE));
  }

  private
  void addCommand(String label)
  {
    mDesc.mItems.Push(new("OptionMenuItemCommand").Init(label, ""));
  }
}
