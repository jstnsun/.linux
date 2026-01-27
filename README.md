<div align="center">
    <h1>〈 Justin's Linux Dotfiles 〉</h1>
    <p><b>Configurations for my personal Linux systems</b></p>
</div>

<hr>

<div align="center">
    <h2>• About •</h2>
</div>
<ul>
    <li>This repository contains my configurations and is tailored for my own use.</li>
    <li>They are tested and used on x86-64 Arch Linux and derivative distributions.</li>
    <li>Feel free to copy and use them, but support for other systems is not guaranteed as-is.</li>
    <li>Fixes, improvements, optimizations, and other sorts of contributions are welcome.</li>
</ul>

<div align="center">
    <h2>• Setup •</h2>
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
    <h3>♦ Unpacking ♦</h3>
</div>
<p>
    When this repository is cloned, contents will not be placed relative to
    the locations in the table above; rather, they will all be relative to
    <code>$REPO</code>. You will have to either manually move them or use
    <a href="unpack.sh"><code>unpack.sh</code></a> to automate the process.
    As with any random script that can modify your file system, please verify
    its contents before running it, and keep any important data backed up.
</p>

<div align="center">
    <h2>• Acknowledgements •</h2>
</div>
<ul>
    <li><a href="https://wiki.archlinux.org/title/Main_page">ArchWiki</a></li>
    <ul>
        <li><a href="https://wiki.archlinux.org/title/Dotfiles">Dotfiles</a></li>
        <li><a href="https://wiki.archlinux.org/title/XDG_Base_Directory">XDG Base Directory</a></li>
    </ul>
</ul>
