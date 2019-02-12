namespace TomislavKucarS2.dal
{
    public static class RepoFactory
    {
        public static IRepo GetRepo() => new FileRepo();
    }
}