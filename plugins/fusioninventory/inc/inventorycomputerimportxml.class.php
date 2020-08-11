<?php

/**
 * FusionInventory
 *
 * Copyright (C) 2010-2016 by the FusionInventory Development Team.
 *
 * http://www.fusioninventory.org/
 * https://github.com/fusioninventory/fusioninventory-for-glpi
 * http://forge.fusioninventory.org/
 *
 * ------------------------------------------------------------------------
 *
 * LICENSE
 *
 * This file is part of FusionInventory project.
 *
 * FusionInventory is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * FusionInventory is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with FusionInventory. If not, see <http://www.gnu.org/licenses/>.
 *
 * ------------------------------------------------------------------------
 *
 * This file is used to manage the manual import of XML inventory.
 *
 * ------------------------------------------------------------------------
 *
 * @package   FusionInventory
 * @author    David Durieux
 * @copyright Copyright (c) 2010-2016 FusionInventory team
 * @license   AGPL License 3.0 or (at your option) any later version
 *            http://www.gnu.org/licenses/agpl-3.0-standalone.html
 * @link      http://www.fusioninventory.org/
 * @link      https://github.com/fusioninventory/fusioninventory-for-glpi
 *
 */

if (!defined('GLPI_ROOT')) {
   die("Sorry. You can't access directly to this file");
}

/**
 * Manage the manual import of XML inventory.
 */
class PluginFusioninventoryInventoryComputerImportXML extends CommonDBTM  {


   /**
    * Get rights
    *
    * @param string $interface
    * @return array
    */
   function getRights($interface = 'central') {
      return [CREATE  => __('Create')];
   }


   /**
    * Display form for import the XML
    *
    * @global array $CFG_GLPI
    * @return boolean
    */
   function showForm() {
      $target = Plugin::getWebDir('fusioninventory').'/front/inventorycomputerimportxml.php';

      echo "<form action='".$target."' method='post' enctype='multipart/form-data'>";

      echo "<br>";
      echo "<table class='tab_cadre' cellpadding='1' width='600'>";
      echo "<tr>";
      echo "<th>";
      echo __('Import XML file from an Agent', 'fusioninventory')." :";
      echo "</th>";
      echo "</tr>";

      echo "<tr class='tab_bg_1'>";
      echo "<td>";
      echo __('You can use this menu to upload XML generated by an agent. '.
         'The file must have .xml or .ocs extension. '.
         'It\'s also possible to upload <b>ZIP</b> archive directly with a '.
         'collection of XML files. '.
         'Read you agent documentation to see how to generate such XML '.
         'file', 'fusioninventory');
      echo "</td>";
      echo "</tr>";

      echo "<tr class='tab_bg_1'>";
      echo "<td align='center'>";
      echo "<input type='file' name='importfile' value=''/>";
      echo "&nbsp;<input type='submit' value='".__('Import')."' class='submit'/>";
      echo "</td>";
      echo "</tr>";

      echo "</table>";

      Html::closeForm();
      return true;
   }


}
