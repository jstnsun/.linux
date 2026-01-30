<div align="center">
    <h1>〈 Justin's Linux Dotfiles 〉</h1>
    <p><b>Configurations for my personal Linux systems</b></p>
</div>

<hr>

<div align="center">
    <h2>♦ About ♦</h2>
</div>
<ul>
    <li>This repository contains my configurations and is tailored for my own use.</li>
    <li>They are tested and used on x86-64 Arch Linux and derivative distributions.</li>
    <li>Feel free to copy and use them, but support for other systems is not guaranteed as-is.</li>
    <li>Fixes, improvements, optimizations, and other sorts of contributions are welcome.</li>
</ul>

<div align="center">
    <h2>♦ Setup ♦</h2>
</div>
<p>
    This is a bare Git repository with minimal dependencies and setup effort.
    Specifically:
</p>
<ul>
    <li><code>git</code>: for cloning and version control.</li>
    <li><code>sh</code> (or any POSIX-compliant shell): for running provided shell scripts.</li>
</ul>
<p>
    Of course, they are technically unnecessary if you only need or want to
    cherry-pick configurations.
</p>

<p>
    Contents are organized relative to actual system locations as follows,
    where <code>$REPO</code> refers to this repository's root:
</p>
<table align="center">
    <thead>
        <tr>
            <th>Content</th>
            <th>Relative Location</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>.dir/</code> <code>.file</code></td>
            <td><code>$HOME</code></td>
        </tr>
        <tr>
            <td><code>dir/</code></td>
            <td><code>/</code></td>
        </tr>
        <tr>
            <td><code>file</code></td>
            <td><code>$REPO</code></td>
        </tr>
    </tbody>
</table>
<p>
    The justification for this is that my configurations are spread across my
    home directory and root directory, and this is quite simple to manage with
    Git by specifying different working trees for these locations.
</p>

<div align="center">
    <h3>• Installing •</h3>
</div>
<p>
    This repository relies on the structure and variable working tree property
    of a bare Git repository. Thus ideally it should be cloned as a bare
    repository, but then by default remote tracking is not setup and refs are
    ignored. If you want the the best of both worlds, you will have to either
    manually clone and configure this repository or use
    <a href="install.sh"><code>install.sh</code></a><a href="#running-scripts"><sup>1</sup></a>
    to automate the process.
</p>

<p>
    If you opt to use <a href="install.sh"><code>install.sh</code></a><sup><a href="#running-scripts">1</a></sup>,
    you can run one of the commands below. If the script completes
    successfully, this repository will be installed in the same directory from
    which the script was run.
</p>
<ul>
<li>Pipeline:</li>

    curl -fsSL "https://raw.githubusercontent.com/jstnsun/.linux/refs/heads/master/install.sh" | sh

<li>AND list:</li>

    curl -fsSLO "https://raw.githubusercontent.com/jstnsun/.linux/refs/heads/master/install.sh" && \
        chmod +x install.sh && \
        ./install.sh && \
        rm install.sh

</ul>

<div align="center">
    <h3>• Unpacking •</h3>
</div>
<p>
    When this repository is installed, contents will not be placed relative to
    the locations in the table above; rather, they will all be relative to
    <code>$REPO</code>. You will have to either manually move them or use
    <a href="unpack.sh"><code>unpack.sh</code></a><a href="#running-scripts"><sup>1</sup></a>
    to automate the process.
</p>

<div align="center">
    <h2>♦ Disclaimers ♦</h2>
</div>

<div align="center">
    <h3 id="running-scripts">• Running Scripts •</h3>
</div>
<p>
    As with any script you find, you should review its contents before running
    it. If it can modify data on your system, make sure any important data is
    backed up before running it. The scripts in this repository have been
    tested for major issues, but they may still contain minor issues.
</p>

<div align="center">
    <h2>♦ Acknowledgements ♦</h2>
</div>
<ul>
    <li><a href="https://wiki.archlinux.org/title/Main_page">ArchWiki</a></li>
    <ul>
        <li><a href="https://wiki.archlinux.org/title/Dotfiles">Dotfiles</a></li>
        <li><a href="https://wiki.archlinux.org/title/XDG_Base_Directory">XDG Base Directory</a></li>
    </ul>
    <li><a href="https://www.shellcheck.net/">ShellCheck</a></li>
</ul>
