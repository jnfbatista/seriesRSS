seriesRSS
=========

Requirements
------------

Ruby: 1.9.3


Config File
-----------

It should receive a yaml file, with multiple entries describing each of
the torrent files one wishes to save. Each entry should consist of an
identifier for the torrent, a target RSS feed URL and a relative path to
where to save the torrent file.


    torrents:
        some_id:
            url: http://www.ezrss.it/search/index.php?simple&show_name=Game+of+thrones&mode=rss
            path: some_id/so_2

        some_other_id:
            url: http://www.ezrss.it/search/index.php?show_name=House&date=&quality=&release_group=&mode=rss
            path: some_other_id/so_2
            frequency: 2h


