/*
 * Copyright (C) 2006 Ronald Lamprecht
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */
 
#ifndef LEV_PROXY_HH_INCLUDED
#define LEV_PROXY_HH_INCLUDED

#include <map>
#include <string>
#include <xercesc/dom/DOMDocument.hpp>

namespace enigma { namespace lev {
    enum controlType {force, balance, key, other};
    enum scoreUnitType {duration, number};
    enum scoreTargetType {time, pushes, moves, lua};
    
    /**
     * A standin for an addressable level file and its level metadata.
     * Every level index and the commandline register their levels with the
     * known level metadata. The unique proxy is henceforth used to access
     * level data and to load the level. The level metadata are updated on
     * level load and can be updated without a complete load of the level.
     * 
     * The supplied level address is analysed and normalized to a unique
     * schema. Urls, Enigma resource path addresses, absolute paths and
     * Oxyd level addresses are supported.
     *
     * Mismatches of levels to requested levels are detected on level load.
     * Old level revisions on the users Enigma home directory shadowing new
     * revisions of a new Enigma installation will be handled, too.
     */
    class Proxy {
    public:
        enum pathType { pt_url, pt_resource, pt_absolute, pt_oxyd};
        static const XMLCh levelNS[]; // the XML namespace
        static Proxy *loadedLevel(); // tmp ?
        
        /**
         * The registration of a level.
         * @arg levelPath  as stored in indices or entered on the commandline.
         *            valid formats are: 
         *            welcome, ./firefox, stable/welcome:, ftp://..., #oxyd#17
         * @arg indexPath  a path identifier of the index in strict standard form:
         *            stable, "", #commandline, #history, #oxyd, http://...
         *            resource path level packs use the subdirectory name below
         *            levels or "", zipped packs the filename without suffix
         * @arg levelId  the version independent level id as used for scoring
         * @arg levelTitel the english titel of the level
         * @arg levelAuthor the name of the author
         * @arg levelScoreVersion the score version
         * @arg levelRelease the level compatibility release version
         * @arg levelHasEasymode support of an easy mode
         */
        static Proxy *registerLevel(std::string levelPath, std::string indexPath,
                std::string levelId, std::string levelTitel, std::string levelAuthor,
                int levelScoreVersion, int levelRelease, bool levelHasEasymode);

        void loadLevel();
        void loadMetadata();
        
        /**
         * Retrieve and translate a level string. The key may be "titel",
         * "subtitel" or any level specific string key. The priorities for
         * translation are as follows: protected translation - gettext 
         * translation - public translation - protected english - key
         * @arg key     the key for the search string
         * @return      the translation of the string
         */
        std::string getLocalizedString(const std::string &key);
        
        std::string getId();
        int getScoreVersion();
        int getReleaseVersion();
        int getRevisionNumber();
        std::string getAuthor();
        std::string getTitel(); // english titel
        bool hasEasymode();
        std::string getContact();
        std::string getHomepage();
        controlType getControl();
        scoreUnitType getScoreUnit();
        std::string getScoreTarget();
        std::string getCredits(bool infoUsage);
        std::string getDedication(bool infoUsage);
        int getEasyScore();
        int getDifficultScore();
        
        /**
         * the level address that can be used independent of a level pack
         * as a crossreference.
         */
        std::string getNormLevelPath();
        
        /**
         * the type of the level address
         */
        Proxy::pathType getNormPathType();
        std::string getAbsLevelPath();
    private:
        static Proxy *currentLevel;
        static std::map<std::string, Proxy *> cache;
        
        pathType normPathType;
        std::string normLevelPath; // stable/welcome, #oxyd#17, http://..., ~/test
        std::string absLevelPath;
        std::string id; // level id - old filename or indexname
        std::string titel; // old name
        std::string author;
        int scoreVersion;
        int releaseVersion;
        int revisionNumber;
        bool hasEasymodeFlag;
        scoreUnitType scoreUnit;
        XERCES_CPP_NAMESPACE_QUALIFIER DOMDocument *doc;
        XERCES_CPP_NAMESPACE_QUALIFIER DOMElement *infoElem;
        XERCES_CPP_NAMESPACE_QUALIFIER DOMNodeList *stringList;
        
        Proxy(pathType thePathType, std::string theNormLevelPath,
                std::string levelId, std::string levelTitel, std::string levelAuthor,
                int levelScoreVersion, int levelRelease, bool levelHasEasymode);
        ~Proxy();
        void release();
        void load(bool onlyMetadata);
        void loadLuaCode();
        int scoreText2Int(std::string text);
    };
}} // namespace enigma::lev
#endif

